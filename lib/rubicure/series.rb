module Rubicure
  # Precure TV series (ex. Smile Precure, Dokidoki Orecure)
  # this is record of "config/series.yml"
  class Series < Hash
    include Hashie::Extensions::MethodAccess
    include Rubicure::Concerns::Util
    include Enumerable

    using Rubicure::Concerns::Gengou

    @cache = {}
    @config = nil

    # @param [Rubicure::Series,Rubicure::Girl] other
    #
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

    # Whether series is on air
    #
    # @param [Time,Date,String] arg Time, Date or date like String (ex. "2013-12-16")
    #
    # @return [Boolean]
    def on_air?(arg)
      date = to_date(arg)

      return false unless respond_to?(:started_date)

      if respond_to?(:ended_date)
        # ended title
        (started_date..ended_date).cover?(date)
      else
        # on air title
        started_date <= date
      end
    end

    # @return [Array<Rubicure::Girl>]
    def girls
      unless @girls
        @girls = []
        if has_key?(:girls)
          fetch(:girls).each do |girl_name|
            @girls << Rubicure::Girl.find(girl_name.to_sym)
          end
        end
      end

      @girls
    end

    alias_method :each_without_girls, :each

    def each(&block)
      girls.each(&block)
    end

    # @return [String] json string
    def to_json(*_args)
      original_hash = {}
      each_without_girls do |k, v|
        original_hash[k] = v
      end
      original_hash.to_json
    end

    # Whether Heisei precure
    def heisei?
      started_date.heisei? || ended_date.heisei?
    end

    # Whether Reiwa precure
    def reiwa?
      # TODO: Remove after StarTwinkle Precure is finished
      return true unless has_key?(:ended_date)

      started_date.reiwa? || ended_date.reiwa?
    end

    class << self
      # @return [Array<Symbol>]
      def names
        config.keys
      end

      # @return [Array<Symbol>]
      def uniq_names
        uniq_names = []
        config.each do |name, series|
          uniq_names << name unless uniq_names.any? {|uniq_name| config[uniq_name][:title] == series[:title] }
        end
        uniq_names
      end

      # @return [Hash] content of config/series.yml
      def config
        unless @config
          config_file = "#{File.dirname(__FILE__)}/../../config/series.yml"
          @config = YAML.load_file(config_file).deep_symbolize_keys
        end
        @config
      end

      # @return [Hash] content of config/precure.yml
      def reload_config!
        @cache = {}
        @config = nil
        config
      end

      # @param [Symbol] series_name
      def valid?(series_name)
        names.include?(series_name)
      end

      # @param series_name [Symbol]
      # @return [Rubicure::Series]
      # @raise arg is not precure
      def find(series_name)
        raise UnknownSeriesError, "unknown series: #{series_name}" unless valid?(series_name)

        @cache ||= {}
        unless @cache[series_name]
          series_config = config[series_name] || {}
          series_config.compact!

          @cache[series_name] = Rubicure::Series[series_config]
        end

        @cache[series_name]
      end
    end
  end
end
