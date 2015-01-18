describe Rubicure::Girl do
  let(:girl) do
    girl = Rubicure::Girl[
        human_name:        human_name,
        precure_name:      precure_name,
        cast_name:         cast_name,
        created_date:      created_date,
        extra_names:       extra_names,
        transform_message: transform_message,
        attack_messages:   attack_messages,
        transform_calls:   transform_calls,
        color:             color,
    ]
    girl.io = mock_io
    girl
  end
  let(:mock_io) { StringIO.new }

  let(:human_name)     { "黄瀬やよい" }
  let(:precure_name)   { "キュアピース" }
  let(:cast_name)      { "金元寿子" }
  let(:created_date)   { "2012-02-19" }
  let(:extra_names)    { %w(プリンセスピース ウルトラピース) }
  let(:color)          { "yellow" }
  let(:transform_message) do
    <<EOF
プリキュアスマイルチャージ！
GO! GO! Let's GO ピース！
ピカピカピカリンジャンケンポン！ キュアピース！
EOF
  end
  let(:attack_messages) do
    [
      "プリキュアピースサンダー！",
      "プリキュアピースサンダーハリケーン！",
    ]
  end
  let(:transform_calls){ %w(smile_charge) }

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
  end

  describe "#uniq_names" do
    subject { Rubicure::Girl.uniq_names }

    let(:containing_name_alias_count) { Rubicure::Girl.names.count }

    its(:count) { should < containing_name_alias_count }
  end

  describe "#attack!" do
    subject { girl.attack! }

    context "When human" do
      it { expect { subject }.to raise_error }
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
      it { expect{ subject }.not_to raise_error }
    end

    context "When Milkey Rose calls sky_rose_translate!" do
      let(:girl) { Milky.rose }
      let(:transform_call) { "sky_rose_translate!" }
      it { expect{ subject }.not_to raise_error }
    end

    context "When Milky Rose calls metamorphose" do
      let(:girl) { Milky.rose }
      let(:transform_call) { "metamorphose" }

      it { expect{ subject }.to raise_error NameError }
    end
  end

  shared_examples :a_humanize_method do
    it { should be_an_instance_of Rubicure::Girl }
    it { expect(girl.current_state).to eq 0 }
  end

  describe "humanize!" do
    let(:humanize!){ girl.humanize! }

    context "When not transformed" do
      subject!{ humanize! }

      it_behaves_like :a_humanize_method
    end

    context "When after transformed" do
      before do
        girl.transform!
      end

      subject!{ humanize! }

      it_behaves_like :a_humanize_method
    end
  end

  describe "#colors" do
    subject{ Rubicure::Girl.colors }

    let(:expected) do
      %i(
        black
        blue
        green
        pink
        purple
        red
        white
        yellow
      )
    end

    it { should contain_exactly(*expected) }
  end

  describe "dynamic color methods" do
    # NOTE: cure peace is yellow
    it { expect(girl).to be_yellow }
    it { expect(girl).not_to be_pink }
  end
end
