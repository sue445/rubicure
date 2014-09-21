require 'active_support/all'
require 'yaml'
require 'hashie'
require "rubicure/version"
require "rubicure/concerns/util"
require "rubicure/series"
require "rubicure/girl"
require "rubicure/core"
require "rubicure/movie"
require "rubicure/cure"

module Rubicure
  def self.core
    Rubicure::Core.instance
  end
end

module Precure
  def self.method_missing(name, *args, &block)
    Rubicure.core.send(name, *args, &block)
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
