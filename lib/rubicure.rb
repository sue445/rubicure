require "active_support/core_ext"
require 'yaml'
require 'hashie'
require "rubicure/version"
require "rubicure/series"
require "rubicure/girl"
require "rubicure/core"

module Rubicure
  def self.core
    Rubicure::Core.instance
  end
end

["Pretty", "Pre"].each do |module_name|
  eval <<-RUBY
    module #{module_name}
      def self.cure
        Rubicure.core
      end
    end
  RUBY
end

module Cure
  def self.method_missing(name, *args)
    if Rubicure::Girl.valid?(name)
      Rubicure::Girl.find(name)
    else
      super
    end
  end
end

module Shiny
  def self.luminous
    Rubicure::Girl.find(:luminous)
  end
end

module Milky
  def self.rose
    Rubicure::Girl.find(:rose)
  end
end
