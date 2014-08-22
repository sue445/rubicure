module Rubicure
  # Precure All Stars Movie
  #
  # this is record of "config/movies.yml"
  class Movie < Hash
    include Hashie::Extensions::MethodAccess

    @@cache = {}
    @@config = nil

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

    # @return [Hash] content of config/movies.yml
    def self.config
      unless @@config
        config_file = "#{File.dirname(__FILE__)}/../../config/movies.yml"
        @@config = YAML.load_file(config_file).deep_symbolize_keys
      end
      @@config
    end

    # @return [Hash] content of config/movies.yml
    def self.reload_config!
      @@cache = {}
      @@config = nil
      config
    end

    # @param [Symbol] series_name
    def self.valid?(series_name)
      names.include?(series_name)
    end

    # @param movie_name [Symbol]
    # @return [Rubicure::Movie]
    # @raise arg is invalid
    def self.find(movie_name)
      raise "unknown movie: #{movie_name}" unless valid?(movie_name)

      unless @@cache[movie_name]
        movie_config = config[movie_name] || {}
        movie_config.reject! { |k, v| v.nil? }

        @@cache[movie_name] = Rubicure::Movie[movie_config]
      end

      @@cache[movie_name]
    end
  end
end
