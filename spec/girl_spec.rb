describe Rubicure::Girl do
  describe "#name" do
    let(:girl){
      Rubicure::Girl.new(
          human_name:      human_name,
          precure_name:    precure_name,
          extra_names:     extra_names,
          transform_message: transform_message
      )
    }

    let(:human_name)     { "黄瀬やよい" }
    let(:precure_name)   { "キュアピース" }
    let(:extra_names)    { %w(プリンセスピース ウルトラピース) }
    let(:transform_message){
      <<EOF
プリキュアスマイルチャージ！
GO! GO! Let's GO ピース！
ピカピカピカリンジャンケンポン！ キュアピース！
EOF
    }

    context "when before transform" do
      it{ expect(girl.name).to eq human_name }
    end

    context "when after 1st transform" do
      before do
        girl.transform
      end

      it{ expect(girl.name).to eq precure_name }
    end

    context "when after 2nd transform" do
      before do
        girl.transform
        girl.transform
      end

      it{ expect(girl.name).to eq extra_names[0] }
    end

    context "when after 3nd transform" do
      before do
        girl.transform
        girl.transform
        girl.transform
      end

      it{ expect(girl.name).to eq extra_names[1] }
    end

    context "when after final transform" do
      before do
        girl.transform
        girl.transform
        girl.transform
        girl.transform
      end

      # return to human
      it{ expect(girl.name).to eq human_name }
    end
  end
end
