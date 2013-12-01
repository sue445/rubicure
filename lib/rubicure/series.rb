module Rubicure
  require 'yaml'
  require 'hashie'

  class Series < Hash
    include Hashie::Extensions::MethodAccess

    # @return [Array<Symbol>]
    def self.names
      Series.config.keys
    end

    def self.valid?(series_name)
      names.include?(series_name)
    end

    # @return [Hash]
    def self.config
      config_file = "#{File.dirname(__FILE__)}/../../config/series.yml"
      YAML.load_file(config_file).deep_symbolize_keys
    end

    # @param series_name [Symbol]
    # @return [Series]
    # @raise arg is not precure
    def self.fetch(series_name)
      series_config = Series.config

      raise "unknown series: #{series_name}" unless series_config.key?(series_name)
      Series[series_config[series_name] || {}]
    end

    alias :[] :fetch
  end
end
