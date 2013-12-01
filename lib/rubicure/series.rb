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
      series_name = series_alias(series_name)
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
      series_name = series_alias(series_name)

      raise "unknown series: #{series_name}" unless series_config.key?(series_name)
      Series[series_config[series_name] || {}]
    end

    alias :[] :fetch

    # @param [Symbol] alias_series_name
    # @return [Symbol]
    def self.series_alias(alias_series_name)
      config_file = "#{File.dirname(__FILE__)}/../../config/title_alias.yml"
      titles = YAML.load_file(config_file).deep_symbolize_keys

      titles.key?(alias_series_name) ? titles[alias_series_name].to_sym : alias_series_name
    end
  end
end
