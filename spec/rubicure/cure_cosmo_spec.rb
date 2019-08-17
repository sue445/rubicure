describe "Cure.cosmo" do # rubocop:disable RSpec/DescribeClass
  let(:girl) { Cure.cosmo }

  after do
    girl.rollback
  end

  describe "#transform!" do
    context "with :rainbow_perfume" do
      subject { girl.transform!(:rainbow_perfume) }

      it "change to either マオ, ブルーキャット or バケニャーン" do
        subject

        expect(girl.name).to match(/^(マオ|ブルーキャット|バケニャーン)$/)
      end
    end

    context "without arg" do
      subject { girl.transform! }

      it { expect { subject }.to change { girl.name }.from("ユニ").to("キュアコスモ") }
    end
  end

  describe "#rollback" do
    subject { girl.rollback }

    it "rollback to ユニ" do
      girl.transform!(:rainbow_perfume)

      subject

      expect(girl.name).to eq "ユニ"
    end
  end
end
