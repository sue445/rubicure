describe Rubicure::Girl do
  let(:girl) do
    girl = Rubicure::Girl[
        girl_name:              girl_name,
        human_name:             human_name,
        precure_name:           precure_name,
        cast_name:              cast_name,
        created_date:           created_date,
        extra_names:            extra_names,
        transform_message:      transform_message,
        attack_messages:        attack_messages,
        transform_calls:        transform_calls,
        color:                  color,
        random_transform_words: random_transform_words,
    ]
    girl.io = mock_io
    girl
  end
  let(:mock_io) { StringIO.new }

  let(:girl_name)      { "cure_peace" }
  let(:human_name)     { "黄瀬やよい" }
  let(:precure_name)   { "キュアピース" }
  let(:cast_name)      { "金元寿子" }
  let(:created_date)   { date("2012-02-19") }
  let(:extra_names)    { %w[プリンセスピース ウルトラピース] }
  let(:color)          { "yellow" }
  let(:transform_message) do
    <<~JANKEN
      プリキュアスマイルチャージ！
      GO! GO! Let's GO ピース！
      ピカピカピカリンジャンケンポン！ キュアピース！
    JANKEN
  end
  let(:attack_messages) do
    [
      "プリキュアピースサンダー！",
      "プリキュアピースサンダーハリケーン！",
    ]
  end
  let(:transform_calls) { %w[smile_charge] }
  let(:random_transform_words) { nil }

  describe "#name" do
    context "when before transform" do
      it { expect(girl.name).to eq human_name }
    end

    context "when after 1st transform" do
      before do
        girl.transform!
      end

      it { expect(girl.name).to eq precure_name }
      it { expect(mock_io.string).to eq transform_message }
    end

    context "when after 2nd transform" do
      before do
        girl.transform!
        girl.transform!
      end

      it { expect(girl.name).to eq extra_names[0] }
    end

    context "when after 3nd transform" do
      before do
        girl.transform!
        girl.transform!
        girl.transform!
      end

      it { expect(girl.name).to eq extra_names[1] }
    end

    context "when after final transform" do
      before do
        girl.transform!
        girl.transform!
        girl.transform!
        girl.transform!
      end

      # return to human
      it { expect(girl.name).to eq human_name }
    end
  end

  describe "transform!" do
    context "when Cure miracle" do
      let(:girl) do
        girl = Rubicure::Girl[
          girl_name:         "cure_miracle",
          human_name:        "朝日奈みらい",
          precure_name:      "キュアミラクル",
          cast_name:         "高橋李依",
          created_date:      "2016-02-07",
          extra_names:       nil,
          transform_message: nil,
          attack_messages:   nil,
          transform_calls:   ["cure_up_rapapa"],
          color:             "pink",
          birthday:          "6/12",
          transform_styles:  {
            diamond: {
              precure_name:      "キュアミラクル（ダイヤスタイル）",
              transform_message: "",
            },
            ruby:    {
              precure_name:      "キュアミラクル（ルビースタイル）",
              transform_message: "",
            },
          },
        ]

        girl.io = mock_io
        girl
      end

      context "transform! with diamond" do
        before do
          girl.transform!(:diamond)
        end

        it { expect(girl.name).to eq "キュアミラクル（ダイヤスタイル）" }
        it { expect(girl.state_names).to eq ["朝日奈みらい", "キュアミラクル（ダイヤスタイル）"] }
      end

      context "transform! with ruby" do
        before do
          girl.transform!(:ruby)
        end

        it { expect(girl.name).to eq "キュアミラクル（ルビースタイル）" }
        it { expect(girl.state_names).to eq ["朝日奈みらい", "キュアミラクル（ルビースタイル）"] }
      end

      context "cure_up_rapapa! with diamond" do
        before do
          girl.cure_up_rapapa!(:diamond)
        end

        it { expect(girl.name).to eq "キュアミラクル（ダイヤスタイル）" }
        it { expect(girl.state_names).to eq ["朝日奈みらい", "キュアミラクル（ダイヤスタイル）"] }
      end
    end

    context "when Cure summer" do
      let(:girl_name)       { "cure_summer" }
      let(:human_name)      { "夏海まなつ" }
      let(:precure_name)    { "キュアサマー" }
      let(:cast_name)       { "ファイルーズあい" }
      let(:created_date)    { date("2021-02-28") }
      let(:transform_calls) { %w[precure_tropical_change] }
      let(:color)           { "white" }

      let(:transform_message) do
        <<~MSG
          プリキュア！トロピカルチェンジ！
          レッツメイク！キャッチ！
          チーク！
          アイズ！
          ヘアー！
          リップ！
          ドレス！
          ときめく常夏！キュアサマー！
          はぁー！
          ${random_transform_word}
          トロピカル～ジュ！プリキュア！
        MSG
      end

      let(:random_transform_words) do
        %w[
          4人揃って！
          今日も元気だ！
        ]
      end

      it "stdout includes one of random_transform_words" do
        girl.transform!

        expect(mock_io.string).to include("4人揃って！").or include("今日も元気だ！")
      end
    end
  end

  describe "#==" do
    subject { girl == other_girl }

    context "same object" do
      let(:other_girl) { girl }

      it { should be true }
    end

    context "copied object" do
      let(:other_girl) { girl.dup }

      it { should be true }
    end

    context "precure and human" do
      let(:transformed_girl) { girl.dup.transform! }
      let(:other_girl) { transformed_girl }

      it { expect(girl.name).not_to eq transformed_girl.name }
      it { should be true }
    end

    context "other precure" do
      let(:other_girl) { Rubicure::Girl.find(:passion) }

      it { should be false }
    end
  end

  describe "#find" do
    subject { Rubicure::Girl.find(girl_name) }

    let(:girl_name) { :peace }

    it { should be_an_instance_of Rubicure::Girl }
    its(:precure_name) { should == "キュアピース" }
    its(:girl_name)    { should == "cure_peace" }
  end

  describe "#uniq_names" do
    subject { Rubicure::Girl.uniq_names }

    let(:containing_name_alias_count) { Rubicure::Girl.names.count }

    its(:count) { should < containing_name_alias_count }
  end

  describe "#attack!" do
    subject { girl.attack! }

    context "When human" do
      it { expect { subject }.to raise_error Rubicure::RequireTransformError }
    end

    context "When precure" do
      before do
        girl.transform!
      end

      it { should eq "プリキュアピースサンダー！" }
    end
  end

  describe "#method_missing" do
    subject { girl.send(transform_call) }

    before do
      girl.io = mock_io
      girl.humanize!
    end

    context "When Cure Lemonade calls metamorphose" do
      let(:girl) { Cure.lemonade }
      let(:transform_call) { "metamorphose" }

      it { expect { subject }.not_to raise_error }
    end

    context "When Milkey Rose calls sky_rose_translate!" do
      let(:girl) { Milky.rose }
      let(:transform_call) { "sky_rose_translate!" }

      it { expect { subject }.not_to raise_error }
    end

    context "When Milky Rose calls metamorphose" do
      let(:girl) { Milky.rose }
      let(:transform_call) { "metamorphose" }

      it { expect { subject }.to raise_error NameError }
    end
  end

  shared_examples :a_humanize_method do
    it { should be_an_instance_of Rubicure::Girl }
    it { expect(girl.current_state).to eq 0 }
  end

  describe "humanize!" do
    let(:humanize!) { girl.humanize! }

    context "When not transformed" do
      subject! { humanize! }

      it_behaves_like :a_humanize_method
    end

    context "When after transformed" do
      before do
        girl.transform!
      end

      subject! { humanize! } # rubocop:disable RSpec/LeadingSubject

      it_behaves_like :a_humanize_method
    end
  end

  describe "#colors" do
    subject { Rubicure::Girl.colors }

    let(:expected) do
      %i[
        black
        blue
        gold
        green
        pink
        purple
        rainbow
        red
        white
        yellow
      ]
    end

    it { should contain_exactly(*expected) }
  end

  describe "dynamic color methods" do
    # NOTE: cure peace is yellow
    it { expect(girl).to be_yellow }
    it { expect(girl).not_to be_pink }
  end

  describe "birthday?" do
    subject { girl.birthday?(curent_date) }

    let(:curent_date) { Date.today }

    context "has birthday" do
      let(:girl) { Cure.flora }

      context "curent_time is birthday" do
        let(:curent_date) { date("2015-04-10") }

        it { should be true }
      end

      context "curent_time is not birthday" do
        let(:curent_date) { date("2015-04-11") }

        it { should be false }
      end
    end

    context "don't have birthday" do
      let(:girl) { Cure.peace }

      it { should be false }
    end
  end

  describe "#full_name" do
    subject { girl.full_name }

    context "has human_full_name" do
      let(:girl) { Cure.scarlet }

      it { should eq "プリンセス・ホープ・ディライト・トワ" }
    end

    context "don't have human_full_name" do
      it { should eq "黄瀬やよい" }
    end
  end

  describe "#heisei?" do
    subject { girl.heisei? }

    it { should eq true }
  end

  describe "#reiwa?" do
    subject { girl.reiwa? }

    # TODO: Add reiwa precure test after cure cosmo is added
    it { should eq false }
  end
end
