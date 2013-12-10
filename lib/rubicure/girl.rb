module Rubicure
  class Girl < Hash
    attr_reader :current_state, :state_names, :extra_names

    include Hashie::Extensions::MethodAccess

    @@cache = {}
    @@config = nil

    def initialize(args={})
      self.merge!(args)
      @current_state = 0
      @extra_names = args[:extra_names] || []
      @state_names = [self.human_name, self.precure_name]
      @state_names += self.extra_names if self.extra_names && !self.extra_names.empty?
    end

    # @return [String] name of current form
    def name
      @state_names[@current_state]
    end

    # human -> precure ( -> extra forms ) -> human ...
    # @return self
    def transform!
      @current_state += 1
      @current_state = 0 unless @current_state < @state_names.length

      puts @transform_message  if @current_state == 1

      self
    end

    def humanize
      @current_state = 0
    end

    # @param girl_name [Symbol]
    # @return [Rubicure::Girl]
    def self.find(girl_name)
      raise "unknown girl: #{girl_name}" unless valid?(girl_name)

      unless @@cache[girl_name]
        girl_config = config[girl_name] || {}
        girl_config.reject! { |k, v| v.nil? }

        @@cache[girl_name] = Rubicure::Girl[girl_config]
      end

      @@cache[girl_name]
    end

    # @return [Array<Symbol>]
    def self.names
      config.keys
    end

    # @return [Hash] content of config/girls.yml
    def self.config
      unless @@config
        config_file = "#{File.dirname(__FILE__)}/../../config/girls.yml"
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

    # @param [Symbol] girl_name
    def self.valid?(girl_name)
      names.include?(girl_name)
    end
  end
end
