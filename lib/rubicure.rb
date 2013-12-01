require "rubicure/version"
require "rubicure/series"
require "rubicure/girl"
require "active_support/core_ext"

module Rubicure
  def method_missing(name, *args)
    if Rubicure::Series.valid?(name)
      Rubicure::Series.fetch(name)
    else
      super
    end
  end
end
