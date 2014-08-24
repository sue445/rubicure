require 'active_support/all'
require 'yaml'
require 'hashie'
require "rubicure/version"
require "rubicure/concerns/util"
require "rubicure/series"
require "rubicure/girl"
require "rubicure/core"
require "rubicure/movie"

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

module Cure
  def self.method_missing(name, *args)
    if Rubicure::Girl.valid?(name)
      Rubicure::Girl.find(name)
    else
      super
    end
  end

  [Cure.peace, Cure.cure_peace].each do |peace|
    class << peace
      HANDS =
        (['グー']   * 13) +
        (['チョキ'] * 14) +
        (['パー']   * 15) +
        ['グッチョッパー']
      MESSAGE = <<EOF
ピカピカピカリン
ジャンケンポン！
（%s）
EOF
      def pikarin_janken
        print_by_line(MESSAGE % HANDS.sample)
      end
      alias janken pikarin_janken
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
