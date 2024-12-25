require "rubicure"
require_relative "common"

code = <<~RUBY
  @manatsu = Cure.summer
  puts @manatsu.name

  @manatsu.precure_tropical_change!
  puts @manatsu.name

  @manatsu.humanize!
  puts @manatsu.name

  @manatsu.precure_tropical_change!
  puts @manatsu.name
RUBY

run code
