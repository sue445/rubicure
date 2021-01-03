[Cure.peace, Cure.cure_peace].each do |peace|
  class << peace
    HANDS =
      (["グー"] * 13) +
      (["チョキ"] * 14) +
      (["パー"] * 15) +
      ["グッチョッパー"]
    MESSAGE = <<~JANKEN.freeze
      ピカピカピカリン
      ジャンケンポン！
      （%s）
JANKEN
    def pikarin_janken
      print_by_line(MESSAGE % HANDS.sample)
    end
    alias_method :janken, :pikarin_janken
  end
end
