module Sample
  module Migrator
    module Syncer
      class Base < ApplicationJob
        ##
        # Number of threads to use for concurrency.
        #
        # Default: 0 (no concurrency)
        attr_accessor :thread_count

        ##
        # Number of times to retry failed operations.
        #
        # Default: 10
        attr_accessor :max_retries

        ##
        # Time in seconds to pause before each retry.
        #
        # Default: 30
        attr_accessor :retry_wait

        ##
        # Optional user-defined identifier to differentiate multiple syncers
        # defined within a single sync model. Currently this is only used
        # in the log messages.
        attr_reader :syncer_id

        attr_accessor :records

        def perform(*records)
          opts = records.extract_options!
          @syncer_id = opts[:syncer_id]
          @thread_count = opts.fetch(:thread_count, 0)
          @max_retries = opts.fetch(:max_retries, 0)
          @retry_wait = opts.fetch(:retry_wait, 0)
          @records = records
          yield(records, opts) if block_given?
          perform_sync
        end

        def perform_sync
          @sync_count = 0
          @skipped_count = 0
          @orphans = thread_count.positive? ? Queue.new : []
          exec_sync(records)
        end

        private

        def exec_sync(records)
          sync_block = proc do |record|
            return unless record

            link = MigratedRecord.where_by_r(record).first_or_initialize(r_a: record)

            sync_record(link)
          end

          if thread_count.positive?
            sync_in_threads(records, sync_block)
          else
            records.each(&sync_block)
          end
        end

        def sync_record(link)
          updated_key = pull_update_from?(link)
          return unless updated_key

          outdated_key = if one_way_migration?
                           updated_key = :r_a
                           :r_b
                         else
                           updated_key == :r_a ? :r_b : :r_a
                         end

          updated_r = link.send(updated_key)
          outdated_r = link.send(outdated_key)
          outdated_r = apply_vals(updated_r, outdated_r)

          unless (outdated_r.persisted? && !outdated_r.changed?) || outdated_r.save
            Rails.logger.error "[sample_migrator] Failed to sync #{updated_r.class.name}##{updated_r.id}"
            Rails.logger.warn outdated_r.errors.inspect
            return
          end

          link.send("#{outdated_key}=", outdated_r)
          link.save
          link
        end

        def sync_in_threads(records, sync_block)
          queue = Queue.new
          queue << records.shift until records.empty?
          num_threads = [thread_count, queue.size].min

          threads = Array.new(num_threads) do
            Thread.new do
              loop do
                record = begin
                  queue.shift(true)
                rescue
                  nil
                end
                record ? sync_block.call(record) : break
              end
            end
          end

          # abort if any thread raises an exception
          while threads.any?(&:alive?)
            if threads.any? { |thr| thr.status.nil? }
              threads.each(&:kill)
              Thread.pass while threads.any?(&:alive?)
              break
            end
            sleep num_threads * 0.1
          end
          threads.each(&:join)
        end

        def apply_vals(updated_r, outdated_r)
          outdated_r ||= self.class::KLASS.new

          if self.class.const_defined?('REQUIRE_MIGRATE')
            self.class::REQUIRE_MIGRATE.each { |a| Syncer.sync(updated_r.send(a)) }
          end

          self.class::ATTRIBUTES.each do |attr|
            next unless outdated_r.respond_to?("#{attr}=") && updated_r.respond_to?(attr)

            val = updated_r.send(attr)
            next unless val

            val.strip if val.is_a?(String) && val.respond_to?(:strip)

            unless val.is_a?(File)
              val = if val.respond_to?(:each)
                      val.map { |a| process_val(a) }
                    else
                      process_val(val)
                    end
            end

            outdated_r.send("#{attr}=", val)
          end
          outdated_r
        end

        def process_val(val)
          val.is_a?(ActiveRecord::Base) ? MigratedRecord.find_opposite(val) : val
        end

        def pull_update_from?(link)
          r_a_at = last_update_for(link.r_a)
          r_b_at = last_update_for(link.r_b)

          return :r_a if !link.new_record? && r_a_at.present? && r_a_at > link.r_a_at
          return :r_a if link.new_record? && r_a_at
          return :r_b if !link.new_record? && r_b_at.present? && r_b_at > link.r_b_at
          :r_b if link.new_record? && r_b_at
        end

        def last_update_for(record)
          %i[updated_at created_at].map { |a| record.try(a) }.compact.sort.last
        end

        def one_way_migration?
          true
        end
      end
    end
  end
end
