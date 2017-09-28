require 'rails/all'

module Sample
  module Migrator
    extend ActiveSupport::Autoload

    class <<self
      attr_writer :config, :config_path

      def database_config
        config['database']
      end

      #
      # Memoized hash of configuration options for the current Rails environment
      # as specified in config/btr_rms_migrator.yml
      #
      # ==== Returns
      #
      # Hash:: configuration options for current environment
      #
      def config
        @config ||=
          begin
            if File.exist?(config_path)
              File.open(config_path) do |file|
                YAML.safe_load(ERB.new(file.read).result)[::Rails.env]
              end
            else
              {}
            end
          end
      end

      def config_path
        @config_path ||= File.join(::Rails.root, 'config', 'btr_rms_migrator.yml')
      end

      def reset
        @config = nil
      end
    end

    autoload :Models
    autoload :Syncer
  end
end

require 'sample/migrations'
require 'sample/migrator/engine'
