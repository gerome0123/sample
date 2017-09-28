module Sample
  module Migrator
    module Syncer
      extend ActiveSupport::Autoload
      autoload :Base


      MAPPINGS = {

      }.freeze

      def self.sync(records, background = false)
        records = Array(records).select { |a| MAPPINGS.any? { |_, v| v.include?(a.class.name) } }
        return if records.blank?
        records.group_by(&:class).each do |k, v|
          syncer = MAPPINGS.find { |_, c| c.include?(k.name) }
          m = background ? :perform_later : :perform_now
          "#{name}::#{syncer.first}".constantize.send(m, *v)
        end
      end
    end
  end
end
