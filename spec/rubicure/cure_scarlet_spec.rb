describe "Cure.scarlet" do # rubocop:disable RSpec/DescribeClass
  describe "!" do
    subject { !Cure.scarlet }

    let(:girl) { Cure.scarlet }

    after do
      girl.rollback
      girl.humanize!
    end

    context "called once" do
      it { expect { subject }.to change { girl.name }.from("紅城トワ").to("トワイライト") }
    end

    context "called twice" do
      before do
        !Cure.scarlet
      end

      it { expect { subject }.to change { girl.name }.from("トワイライト").to("紅城トワ") }
    end

    context "after transform" do
      before do
        girl.transform!
      end

      it { expect { subject }.to change { girl.name }.from("キュアスカーレット").to("トワイライト") }
    end
  end
end
