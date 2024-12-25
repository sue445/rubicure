require "rubicure"
require_relative "common"

code = <<-RUBY
  puts Precure.maho_girls.title

  @mirai = Cure.miracle
  puts @mirai.name

  @mirai.cure_up_rapapa! :diamond
  puts @mirai.name
  @mirai.attack!

  @mirai.humanize!
  puts @mirai.name

  @mirai.cure_up_rapapa! :ruby
  puts @mirai.name
  @mirai.attack!
RUBY

run code
