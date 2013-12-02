module Rubicure
  require "singleton"

  class Core
    include Singleton

    def method_missing(name, *args)
      if valid?(name)
        fetch(name)
      else
        super
      end
    end

    # @return [Array<Symbol>]
    def names
      config.keys
    end

    # @return [Hash]
    def config
      unless @config
        config_file = "#{File.dirname(__FILE__)}/../../config/precure.yml"
        @config = YAML.load_file(config_file).deep_symbolize_keys
      end
      @config
    end

    def valid?(series_name)
      series_name = series_alias(series_name)
      names.include?(series_name)
    end

    # @param [Symbol] alias_series_name
    # @return [Symbol]
    def series_alias(alias_series_name)
      config_file = "#{File.dirname(__FILE__)}/../../config/title_alias.yml"
      titles = YAML.load_file(config_file).symbolize_keys

      titles.key?(alias_series_name) ? titles[alias_series_name].to_sym : alias_series_name
    end

    # @param series_name [Symbol]
    # @return [Series]
    # @raise arg is not precure
    def fetch(series_name)
      series_name = series_alias(series_name)

      raise "unknown series: #{series_name}" unless valid?(series_name)

      series_config = config[series_name] || {}
      series_config.reject! { |k, v| v.nil? }

      Series[series_config]
    end

    alias :[] :fetch
  end
end
