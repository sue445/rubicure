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
        (["グー"] * 13) +
        (["チョキ"] * 14) +
        (["パー"] * 15) +
        ["グッチョッパー"]
      MESSAGE = <<EOF
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

    target.define_singleton_method :! do
      humanize!
      @another_human_name ||= @__another_human_name

      # setup @state_names
      state_names

      # rubocop:disable Style/ParallelAssignment
      @state_names[0], @another_human_name = @another_human_name, @state_names[0]
      # rubocop:enable Style/ParallelAssignment

      self
    end

    target.define_singleton_method :rollback do
      @state_names[0]     = @__original_human_name
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
