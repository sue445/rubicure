module Rubicure
  class Series < Hash
    include Hashie::Extensions::MethodAccess

    @@series_cache = {}
    @@config = nil

    # @param [Time,Date,String] arg Time, Date or date like String (ex. "2013-12-16")
    def on_air?(arg)
      date = to_date(arg)
      if respond_to?(:started_date)
        if respond_to?(:ended_date)
          # ended title
          return (started_date .. ended_date).cover?(date)
        else
          # on air title
          return started_date <= date
        end
      end

      false
    end

    # @return [Array<Rubicure::Girl>]
    def girls
      unless @girls
        @girls = []
        if has_key?(:girls)
          fetch(:girls).each do |info|
            girl_hash = info.symbolize_keys

            # FIXME
            girl_hash[:transform_message] = case girl_hash[:precure_name]
              when "シャイニールミナス", "ミルキィローズ"
                girl_hash[:transform_message]
              else
                "#{fetch(:before_transform_message,"")}#{girl_hash[:transform_message]}#{fetch(:after_transform_message,"")}"
            end
            @girls << Rubicure::Girl.new(girl_hash)
          end
        end
      end

      @girls
    end

    # @return [Array<Symbol>]
    def self.series_names
      config.keys
    end

    # @return [Hash] content of config/precure.yml
    def self.config
      unless @@config
        config_file = "#{File.dirname(__FILE__)}/../../config/series.yml"
        @@config = YAML.load_file(config_file).deep_symbolize_keys
      end
      @@config
    end

    # @return [Hash] content of config/precure.yml
    def self.reload_config!
      @@series_cache = {}
      @@config = nil
      config
    end

    def self.valid?(series_name)
      series_name = series_alias(series_name)
      series_names.include?(series_name)
    end

    # @param [Symbol] alias_series_name
    # @return [Symbol]
    def self.series_alias(alias_series_name)
      config_file = "#{File.dirname(__FILE__)}/../../config/title_alias.yml"
      titles = YAML.load_file(config_file).symbolize_keys

      titles.key?(alias_series_name) ? titles[alias_series_name].to_sym : alias_series_name
    end

    # @param series_name [Symbol]
    # @return [Rubicure::Series]
    # @raise arg is not precure
    def self.find(series_name)
      series_name = series_alias(series_name)

      raise "unknown series: #{series_name}" unless valid?(series_name)

      unless @@series_cache[series_name]
        series_config = config[series_name] || {}
        series_config.reject! { |k, v| v.nil? }

        @@series_cache[series_name] = Series[series_config]
      end

      @@series_cache[series_name]
    end

    private
      # @param arg
      # @return [Date] arg is String or Date
      # @return [Time] arg is Time
      # @return [nil] arg is other
      def to_date(arg)
        case arg
          when Date, Time
            arg
          when String
            Date.parse(arg)
          else
            nil
        end
      end
  end
end
