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

  [Cure.passion, Cure.cure_passion].each do |passion|
    class << passion
      ORIGINAL_HUMAN_NAME = "東せつな"
      ANOTHER_HUMAN_NAME  = "イース"

      def !
        humanize
        @another_human_name ||= ANOTHER_HUMAN_NAME
        @state_names[0], @another_human_name = @another_human_name, @state_names[0]
        self
      end

      def rollback
        @state_names[0]     = ORIGINAL_HUMAN_NAME
        @another_human_name = ANOTHER_HUMAN_NAME
        self
      end
    end
  end

  [Cure.beat, Cure.cure_beat].each do |beat|
    class << beat
      ORIGINAL_HUMAN_NAME = "黒川エレン"
      ANOTHER_HUMAN_NAME  = "セイレーン"

      def !
        humanize
        @another_human_name ||= ANOTHER_HUMAN_NAME
        @state_names[0], @another_human_name = @another_human_name, @state_names[0]
        self
      end

      def rollback
        @state_names[0]     = ORIGINAL_HUMAN_NAME
        @another_human_name = ANOTHER_HUMAN_NAME
        self
      end
    end
  end
end
