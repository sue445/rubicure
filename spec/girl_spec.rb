describe Rubicure::Girl do
  let(:girl) do
    Rubicure::Girl.new(
        human_name:        human_name,
        precure_name:      precure_name,
        extra_names:       extra_names,
        transform_message: transform_message,
        attack_messages:   attack_messages,
    )
  end

  let(:human_name)     { "黄瀬やよい" }
  let(:precure_name)   { "キュアピース" }
  let(:extra_names)    { %w(プリンセスピース ウルトラピース) }
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

  describe "#name" do
    context "when before transform" do
      it { expect(girl.name).to eq human_name }
    end

    context "when after 1st transform" do
      before do
        girl.transform!
      end

      it { expect(girl.name).to eq precure_name }
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
      girl.humanize
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

      it { expect{ subject }.to raise_error NoMethodError }
    end
  end
end
