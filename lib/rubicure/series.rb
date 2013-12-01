module Rubicure
  require 'yaml'
  require 'hashie'

  class Series < Hash
    include Hashie::Extensions::MethodAccess

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
    # @return [Series]
    # @raise arg is not precure
    def self.fetch(series_name)
      series_config = Series.config[series_name]

      raise "unknown series" unless series_config
      Series[series_config]
    end

    alias :[] :fetch
  end
end
