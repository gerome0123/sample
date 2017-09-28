module Sample
  module Migrator
    module Models
      class Base < ActiveRecord::Base
        self.abstract_class = true

        establish_connection Sample::Migrator.database_config

        def self.get_model_name(model, prefix = nil)
          ['Sample::Migrator::Models', prefix, model].compact.join('::')
        end

        def self.table_name
          undecorated_table_name(name)
        end

        def self.belongs_to_as(method_name, as = nil)
          as ||= method_name
          define_method method_name do
            return unless send(:"#{as}_type?") && send(:"#{as}_id?")
            self.class.get_model_name(send(:"#{as}_type")).constantize.find(send(:"#{as}_id"))
          end

          define_method "#{method_name}_eq?" do |val|
            return unless self.class.get_model_name(send(:"#{as}_type")) == val.class.name
            send(:"#{as}_id") == val.id
          end
        end

        def self.unmigrated_records
          ids = []
          all.find_each do |record|
            ids << record.id unless record.migrated?
          end
          where(id: ids)
        end

        def migrated_record
          MigratedRecord.where_by_r(self).first
        end

        def migrated?
          migrated_record.present? && migrated_record.r_a.r_a_at == updated_at
        end

        def created_at
          return self[:updated_at] if self[:created_at].blank?
          self[:created_at]
        end

        def creator_id
          user_id ||= self[:user_id]
          return if user_id.blank? || user_id.zero?
          user = self.class.get_model_name('User').constantize.find(user_id)
          user.try(:username)
        end
      end
    end
  end
end
