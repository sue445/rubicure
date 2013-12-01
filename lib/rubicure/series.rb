module Rubicure
  require 'yaml'

  class Series
    # @return [Array<Symbol>]
    def self.names
      Series.config.keys
    end

    # @return [Hash]
    def self.config
      config_file = "#{File.dirname(__FILE__)}/../../config/series.yml"
      YAML.load_file(config_file).deep_symbolize_keys
    end

    # @param series_name [Symbol]
    # @return [Hash]
    def self.fetch(series_name)
      Series.config[series_name]
    end
  end
end
