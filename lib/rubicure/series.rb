module Rubicure
  require 'yaml'

  class Series
    def self.names
      Series.config.keys
    end

    def self.config
      config_file = "#{File.dirname(__FILE__)}/../../config/series.yml"
      YAML.load_file(config_file).deep_symbolize_keys
    end
  end
end
