module Rubicure
  require "sengiri_yaml"

  # Precure girl (ex. Cure Peace, Cure Rosetta, Cure Honey)
  #
  # this is record of "config/girls/*.yml"
  class Girl < Hash
    include Hashie::Extensions::MethodAccess

    attr_writer :io

    @@cache = {}
    @@config = nil
    @@colors = nil
    @@sleep_sec = 1

    def current_state
      @current_state ||= 0
      @current_state
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
    alias to_s name

    # human -> precure ( -> extra forms ) -> human ...
    # @return [Rubicure::Girl] self
    def transform!
      state = inc_current_state
      print_by_line transform_message  if state == 1

      self
    end

    def humanize!
      @current_state = 0
      self
    end
    alias :humanize :humanize!
    deprecate humanize: "Use #humanize! instead of #humanize"

    def attack!
      raise "require transform" if current_attack_message.blank?

      print_by_line current_attack_message

      current_attack_message
    end

    # @param girl_name [Symbol]
    # @return [Rubicure::Girl]
    def self.find(girl_name)
      raise "unknown girl: #{girl_name}" unless valid?(girl_name)

      unless @@cache[girl_name]
        girl_config = config[girl_name] || {}
        @@cache[girl_name] = Rubicure::Girl[girl_config].tap{ |girl| girl.io = $stdout }
      end

      @@cache[girl_name]
    end

    # @return [Array<Symbol>]
    def self.names
      config.keys
    end

    # @return [Array<Symbol>]
    def self.uniq_names
      config.each_with_object([]) do |(name, girl), uniq_names|
        uniq_names << name unless uniq_names.any? { |uniq_name| config[uniq_name][:precure_name] == girl[:precure_name] }
      end
    end

    # @return [Hash] content of config/girls/*.yml
    def self.config
      unless @@config
        @@config = SengiriYaml.load_dir("#{File.dirname(__FILE__)}/../../config/girls").deep_symbolize_keys
      end
      @@config
    end

    # @return [Hash] content of config/precure.yml
    def self.reload_config!
      @@cache = {}
      @@config = nil
      @@colors = nil
      config
    end

    # @param [Symbol] girl_name
    def self.valid?(girl_name)
      names.include?(girl_name)
    end

    def self.sleep_sec=(sleep_sec)
      @@sleep_sec = sleep_sec
    end

    # return defined colors
    # @return [Array<Symbol>]
    def self.colors
      unless @@colors
        @@colors = config.values.each_with_object([]) { |girl, colors| colors << girl[:color].to_sym }.uniq.sort
      end
      @@colors
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
        sleep(@@sleep_sec) if index > 0
        @io.puts line
        index += 1
      end
    end

    def method_missing(method_name, *args)
      # call Hashie::Extensions::MethodAccess#method_missing
      return super if has_key?(method_name)

      shortened_name = method_name.to_s.
          sub(%r/\Aprecure_|_precure\z/, "").
          sub(%r/!\z/, "")

      return transform!(*args) if transform_calls.include?(shortened_name)

      super
    end
  end
end
