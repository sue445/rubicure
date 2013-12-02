require "active_support/core_ext"
require 'yaml'
require 'hashie'
require "rubicure/version"
require "rubicure/series"
require "rubicure/girl"
require "rubicure/core"

module Rubicure
  def core
    Rubicure::Core.instance
  end
  module_function :core
end

["Pretty", "Pre"].each do |module_name|
  eval <<-RUBY
    module #{module_name}
      def cure
        Rubicure.core
      end
      module_function :cure
    end
  RUBY
end
