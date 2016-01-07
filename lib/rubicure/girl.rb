module Rubicure
  require "sengiri_yaml"

  # Precure girl (ex. Cure Peace, Cure Rosetta, Cure Honey)
  #
  # this is record of "config/girls/*.yml"
  class Girl < Hash
    include Hashie::Extensions::MethodAccess

    attr_writer :io

    def current_state
      @current_state ||= 0
    end

    def state_names
      return @state_names if @state_names

      @state_names = [human_name, precure_name]
      @state_names += Array.wrap(extra_names) if respond_to?(:extra_names)
      @state_names
    end

    def ==(other)
      other.is_a?(self.class) && self.human_name == other.human_name
    end

    # @return [String] name of current form
    def name
      state_names[current_state]
    end
    alias_method :to_s, :name

    # human -> precure ( -> extra forms ) -> human ...
    # @return [Rubicure::Girl] self
    def transform!
      state = inc_current_state
      print_by_line transform_message if state == 1

      self
    end

    def humanize!
      @current_state = 0
      self
    end
    alias_method :humanize, :humanize!
    deprecate humanize: "Use #humanize! instead of #humanize"

    def attack!
      raise "require transform" if current_attack_message.blank?

      print_by_line current_attack_message

      current_attack_message
    end

    def birthday?(date = Date.today)
      return false unless have_birthday?

      # NOTE: birthday is "mm/dd"
      month, day = birthday.split("/")

      birthday_date = Date.new(date.year, month.to_i, day.to_i)

      birthday_date == date
    end

    def have_birthday? # rubocop:disable Style/PredicateName
      respond_to?(:birthday)
    end
    alias_method :has_birthday?, :have_birthday?

    class << self
      attr_writer :sleep_sec

      # @param girl_name [Symbol]
      # @return [Rubicure::Girl]
      def find(girl_name)
        raise "unknown girl: #{girl_name}" unless valid?(girl_name)

        @cache ||= {}
        unless @cache[girl_name]
          girl_config = config[girl_name] || {}
          @cache[girl_name] = Rubicure::Girl[girl_config].tap { |girl| girl.io = $stdout }
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
          uniq_names << name unless uniq_names.any? { |uniq_name| config[uniq_name][:precure_name] == girl[:precure_name] }
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
          @colors = config.values.each_with_object([]) { |girl, colors| colors << girl[:color].to_sym }.uniq.sort
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

      def inc_current_state
        @current_state = current_state + 1
        @current_state = 0 unless @current_state < state_names.length
        @current_state
      end

      def current_attack_message
        attack_messages[@current_state - 1]
      end

      def print_by_line(message)
        index = 0
        message.each_line do |line|
          sleep(self.class.sleep_sec) if index > 0
          @io.puts line
          index += 1
        end
      end

      def method_missing(method_name, *args)
        # call Hashie::Extensions::MethodAccess#method_missing
        return super if has_key?(method_name)

        shortened_name = method_name.to_s.
                         sub(/\Aprecure_|_precure\z/, "").
                         sub(/!\z/, "")

        return transform!(*args) if transform_calls.include?(shortened_name)

        super
      end
  end
end
