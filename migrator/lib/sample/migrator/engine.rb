require 'rails/engine'

module Sample
  module Migrator
    class Engine < Rails::Engine
      isolate_namespace Sample
      engine_name 'sample_migrator'

      initializer 'sample.migrator.checking_migrations' do
        Migrations.new(config, engine_name).check
      end

      def self.root
        @root ||= Pathname.new(File.expand_path('../../../../', __FILE__))
      end
    end
  end
end
