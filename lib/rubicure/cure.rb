module Cure
  Rubicure::Girl.names.each do |girl_name|
    define_singleton_method girl_name do
      Rubicure::Girl.find(girl_name)
    end
  end

  [Cure.peace, Cure.cure_peace].each do |peace|
    class << peace
      HANDS =
        (["グー"] * 13) +
        (["チョキ"] * 14) +
        (["パー"] * 15) +
        ["グッチョッパー"]
      MESSAGE = <<EOF.freeze
ピカピカピカリン
ジャンケンポン！
（%s）
EOF
      def pikarin_janken
        print_by_line(MESSAGE % HANDS.sample)
      end
      alias_method :janken, :pikarin_janken
    end
  end

  def self.define_turnover_methods(target, original_human_name, another_human_name)
    target.instance_variable_set(:@__original_human_name, original_human_name)
    target.instance_variable_set(:@__another_human_name,  another_human_name)

    def target.!
      humanize!
      @another_human_name ||= @__another_human_name

      # rubocop:disable Style/ParallelAssignment
      self[:human_name], @another_human_name = @another_human_name, self[:human_name]
      # rubocop:enable Style/ParallelAssignment

      self
    end

    def target.rollback
      self[:human_name]   = @__original_human_name
      @another_human_name = @__another_human_name
      self
    end
  end

  [Cure.passion, Cure.cure_passion].each do |passion|
    define_turnover_methods(passion, "東せつな", "イース")
  end

  [Cure.beat, Cure.cure_beat].each do |beat|
    define_turnover_methods(beat, "黒川エレン", "セイレーン")
  end

  [Cure.scarlet, Cure.cure_scarlet].each do |scarlet|
    define_turnover_methods(scarlet, "紅城トワ", "トワイライト")
  end
end
