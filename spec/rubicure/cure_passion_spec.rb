describe "Cure.passion" do # rubocop:disable RSpec/DescribeClass
  describe "!" do
    subject { !Cure.passion }

    let(:girl) { Cure.passion }

    after do
      girl.rollback
      girl.humanize!
    end

    context "called once" do
      it { expect { subject }.to change { girl.name }.from("東せつな").to("イース") }
    end

    context "called twice" do
      before do
        !Cure.passion
      end

      it { expect { subject }.to change { girl.name }.from("イース").to("東せつな") }
    end

    context "after transform" do
      before do
        girl.transform!
      end

      it { expect { subject }.to change { girl.name }.from("キュアパッション").to("イース") }
    end
  end
end
