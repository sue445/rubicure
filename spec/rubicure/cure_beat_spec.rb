describe "Cure.beat" do # rubocop:disable RSpec/DescribeClass
  describe "!" do
    subject { !Cure.beat }

    let(:girl) { Cure.beat }

    after do
      girl.rollback
      girl.humanize!
    end

    context "called once" do
      it { expect { subject }.to change { girl.name }.from("黒川エレン").to("セイレーン") }
    end

    context "called twice" do
      before do
        !Cure.beat
      end

      it { expect { subject }.to change { girl.name }.from("セイレーン").to("黒川エレン") }
    end

    context "after transform" do
      before do
        girl.transform!
      end

      it { expect { subject }.to change { girl.name }.from("キュアビート").to("セイレーン") }
    end
  end
end
