require "active_support/all"
require "yaml"
require "hashie"
require "rubicure/version"
require "rubicure/concerns/util"
require "rubicure/concerns/gengou"
require "rubicure/series"
require "rubicure/girl"
require "rubicure/core"
require "rubicure/movie"
require "rubicure/cure"
require "rubicure/errors"
require "rubicure/cure_cosmo"
require "rubicure/cure_peace"

begin
  require "backport_dig"
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

module Precure
  def self.method_missing(name, *args, &block) # rubocop:disable Style/MethodMissing
    Rubicure::Core.instance.send(name, *args, &block)
  end
end

module Shiny
  # @return [Rubicure::Girl] Shiny luminous
  def self.luminous
    Rubicure::Girl.find(:luminous)
  end
end

module Milky
  # @return [Rubicure::Girl] Milky rose
  def self.rose
    Rubicure::Girl.find(:rose)
  end
end
