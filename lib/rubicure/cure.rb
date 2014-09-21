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
