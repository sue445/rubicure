module Rubicure
  # Precure TV series (ex. Smile Precure, Dokidoki Orecure)
  # this is record of "config/series.yml"
  class Series < Hash
    include Hashie::Extensions::MethodAccess
    include Rubicure::Concerns::Util
    include Enumerable

    @@cache = {}
    @@config = nil

    # @param [Rubicure::Series,Rubicure::Girl] other
    # @return [Boolean] other is same Rubicure::Series or Rubicure::Series include Rubicure::Girl
    def ===(other)
      case other
      when self.class
        self == other
      when Rubicure::Girl
        girls.include? other
      else
        false
      end
    end

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
        if key?(:girls)
          fetch(:girls).each do |girl_name|
            @girls << Rubicure::Girl.find(girl_name.to_sym)
          end
        end
      end

      @girls
    end

    def each_with_girls
      girls.each { |girl| yield girl }
    end
    alias :each :each_with_girls

    # @return [Array<Symbol>]
    def self.names
      config.keys
    end

    # @return [Array<Symbol>]
    def self.uniq_names
      uniq_names = []
      config.each do |name, series|
        uniq_names << name unless uniq_names.any? { |uniq_name| config[uniq_name][:title] == series[:title] }
      end
      uniq_names
    end

    # @return [Hash] content of config/series.yml
    def self.config
      unless @@config
        config_file = "#{File.dirname(__FILE__)}/../../config/series.yml"
        @@config = YAML.load_file(config_file).deep_symbolize_keys
      end
      @@config
    end

    # @return [Hash] content of config/precure.yml
    def self.reload_config!
      @@cache = {}
      @@config = nil
      config
    end

    # @param [Symbol] series_name
    def self.valid?(series_name)
      names.include?(series_name)
    end

    # @param series_name [Symbol]
    # @return [Rubicure::Series]
    # @raise arg is not precure
    def self.find(series_name)
      raise "unknown series: #{series_name}" unless valid?(series_name)

      unless @@cache[series_name]
        series_config = config[series_name] || {}
        series_config.reject! { |k, v| v.nil? }

        @@cache[series_name] = Rubicure::Series[series_config]
      end

      @@cache[series_name]
    end
  end
end
