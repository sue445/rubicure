require "active_support/core_ext/array/wrap"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/time/calculations"
require "yaml"
require "hashie"
require "date"
require "json"
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
require "rubicure/cure_passion"
require "rubicure/cure_beat"
require "rubicure/cure_scarlet"

module Precure
  def self.method_missing(name, *args, &block)
    Rubicure::Core.instance.send(name, *args, &block)
  end

  def self.respond_to_missing?(name, include_private)
    Rubicure::Core.instance.respond_to_missing?(name, include_private)
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
