module Rubicure
  require "sengiri_yaml"

  # Precure girl (ex. Cure Peace, Cure Rosetta, Cure Honey)
  #
  # this is record of "config/girls/*.yml"
  class Girl < Hash # rubocop:disable Metrics/ClassLength
    include Hashie::Extensions::MethodAccess

    using Rubicure::Concerns::Gengou

    ATTRIBUTES = [
      :girl_name,
      :human_name,
      :human_full_name,
      :precure_name,
      :cast_name,
      :color,
      :created_date,
      :birthday,
      :transform_message,
      :extra_names,
      :attack_messages,
      :transform_calls,
    ].freeze

    attr_accessor :io

    # @return [Integer]
    def current_state
      @current_state ||= 0
    end

    # @return [Array<String>]
    def state_names
      state_names = [human_name, precure_name]
      state_names += Array.wrap(extra_names) if respond_to?(:extra_names)
      state_names
    end

    # @return [Boolean]
    def ==(other)
      other.is_a?(self.class) && self.human_name == other.human_name
    end

    # @return [String] name of current form
    def name
      state_names[current_state]
    end
    alias_method :to_s, :name

    # human -> precure ( -> extra forms ) -> human ...
    #
    # @param style [Symbol]
    #
    # @return [Rubicure::Girl] self
    #
    # @example
    #   yayoi = Cure.peace
    #
    #   yayoi.name
    #   #=> "黄瀬やよい"
    #
    #   yayoi.transform!
    #
    #   # (レディ？)
    #   # プリキュア・スマイルチャージ！
    #   # (ゴー！ゴー！レッツ・ゴー！ピース！！)
    #   # ピカピカピカリンジャンケンポン！ キュアピース！
    #   # 5つの光が導く未来！
    #   # 輝け！スマイルプリキュア！
    #
    #   yayoi.name
    #   #=> "キュアピース"
    def transform!(style = nil)
      if style
        raise "Unknown style: #{style}" unless has_transform_style?(style)

        @current_transform_style = style
      end

      state = inc_current_state
      print_by_line transform_message if state == 1

      self
    end

    # Rollback to human
    #
    # @example
    #   yayoi = Cure.peace
    #   yayoi.transform!
    #   yayoi.name
    #   #=> "キュアピース"
    #
    #   yayoi.humanize!
    #   yayoi.name
    #   #=> "黄瀬やよい"
    def humanize!
      @current_state = 0
      @current_transform_style = nil
      self
    end

    # Attack to enemy
    #
    # @raise [RequireTransformError] current form is human
    #
    # @example
    #   yayoi = Cure.peace
    #   yayoi.transform!
    #
    #   yayoi.attack!
    #
    #   # プリキュア！ピースサンダー！！
    def attack!
      raise RequireTransformError, "require transform" if current_attack_message.blank?

      print_by_line current_attack_message

      current_attack_message
    end

    # Whether `date` is her birthday
    #
    # @param date [Date]
    #
    # @return [Boolean]
    #
    # @example
    #   Cure.twinkle.birthday?(Date.parse("2015-9-12"))
    #   #=> true
    def birthday?(date = Date.today)
      return false unless have_birthday?

      # NOTE: birthday is "mm/dd"
      month, day = birthday.split("/")

      birthday_date = Date.new(date.year, month.to_i, day.to_i)

      birthday_date == date
    end

    # Whether she has birthday
    #
    # @return [Boolean]
    #
    # @example
    #   Cure.peace.have_birthday?
    #   #=> false
    #
    #   Cure.twinkle.has_birthday?
    #   #=> true
    def have_birthday? # rubocop:disable Naming/PredicateName
      has_key?(:birthday)
    end
    alias_method :has_birthday?, :have_birthday?

    # returns `human_full_name` or `human_name`
    #
    # @return [String]
    def full_name
      human_full_name.presence || human_name
    end

    # Whether Heisei precure
    def heisei?
      created_date.heisei?
    end

    # Whether Reiwa precure
    def reiwa?
      created_date.reiwa?
    end

    ATTRIBUTES.each do |attribute|
      define_method attribute do
        if @current_transform_style
          dig(:transform_styles, @current_transform_style, attribute) || self[attribute]
        else
          self[attribute]
        end
      end
    end

    class << self
      attr_writer :sleep_sec

      # @param girl_name [Symbol]
      # @return [Rubicure::Girl]
      def find(girl_name)
        raise "unknown girl: #{girl_name}" unless valid?(girl_name)

        @cache ||= {}
        unless @cache[girl_name]
          girl_config = config[girl_name] || {}
          @cache[girl_name] = Rubicure::Girl[girl_config].tap {|girl| girl.io = $stdout }
        end

        @cache[girl_name]
      end

      # @return [Array<Symbol>]
      def names
        config.keys
      end

      # @return [Array<Symbol>]
      def uniq_names
        config.each_with_object([]) do |(name, girl), uniq_names|
          uniq_names << name unless uniq_names.any? {|uniq_name| config[uniq_name][:precure_name] == girl[:precure_name] }
        end
      end

      # @return [Hash] content of config/girls/*.yml
      def config
        unless @config
          @config = SengiriYaml.load_dir("#{File.dirname(__FILE__)}/../../config/girls").deep_symbolize_keys
        end
        @config
      end

      # @return [Hash] content of config/precure.yml
      def reload_config!
        @cache = {}
        @config = nil
        @colors = nil
        config
      end

      # @param [Symbol] girl_name
      def valid?(girl_name)
        names.include?(girl_name)
      end

      def sleep_sec
        @sleep_sec ||= 1
      end

      # return defined colors
      # @return [Array<Symbol>]
      def colors
        unless @colors
          @colors = config.values.each_with_object([]) {|girl, colors| colors << girl[:color].to_sym }.uniq.sort
        end
        @colors
      end
    end

    colors.each do |color|
      define_method "#{color}?" do
        self.color.to_sym == color
      end
    end

    private

      def has_transform_style?(style)
        return false unless has_key?(:transform_styles)

        transform_styles.keys.map(&:to_sym).include?(style.to_sym)
      end

      def inc_current_state
        @current_state = current_state + 1
        @current_state = 0 unless @current_state < state_names.length
        @current_state
      end

      def current_attack_message
        attack_messages[current_state - 1] if current_state > 0
      end

      def print_by_line(message)
        index = 0
        message.each_line do |line|
          sleep(self.class.sleep_sec) if index > 0
          io.puts line
          index += 1
        end
      end

      def method_missing(method_name, *args)
        return super unless respond_to_missing?(method_name, false)

        transform!(*args)
      end

      def respond_to_missing?(method_name, _include_private)
        # call Hashie::Extensions::MethodAccess#method_missing
        return false if has_key?(method_name)

        return false unless has_key?(:transform_calls)

        shortened_name = method_name.to_s.
                           sub(/\Aprecure_|_precure\z/, "").
                           sub(/!\z/, "")

        transform_calls.include?(shortened_name)
      end
  end
end
