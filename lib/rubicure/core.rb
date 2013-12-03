module Rubicure
  require "singleton"

  class Core
    include Singleton

    def initialize
      @series_cache = {}
    end

    def method_missing(name, *args)
      unmarked_precure = fetch(:unmarked)

      if valid?(name)
        fetch(name)
      elsif unmarked_precure.respond_to?(name)
        unmarked_precure.send(name, *args)
      else
        super
      end
    end

    # @return [Array<Symbol>]
    def series_names
      config.keys
    end

    # @return [Hash] content of config/precure.yml
    def config
      unless @config
        config_file = "#{File.dirname(__FILE__)}/../../config/precure.yml"
        @config = YAML.load_file(config_file).deep_symbolize_keys
      end
      @config
    end

    # @return [Hash] content of config/precure.yml
    def reload_config!
      @series_cache = {}
      @config = nil
      config
    end

    def valid?(series_name)
      series_name = series_alias(series_name)
      series_names.include?(series_name)
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

      unless @series_cache[series_name]
        series_config = config[series_name] || {}
        series_config.reject! { |k, v| v.nil? }

        @series_cache[series_name] = Series[series_config]
      end

      @series_cache[series_name]
    end

    alias :[] :fetch

    # @return [Series] current precure
    # @raise not onair!
    def now
      current_time = Time.now
      series_names.each do |name|
        series = fetch(name)
        return series if series.on_air?(current_time)
      end
      raise "Not on air precure!"
    end

    alias :current :now

    # @return [Array<Rubicure::Girl>]
    def all_stars
      unless @all_stars
        @all_stars = []
        series_names.each do |name|
          series = fetch(name)
          @all_stars += series.girls
        end

        @all_stars.uniq!{|girl| girl.precure_name }
      end

      @all_stars
    end
  end
end
