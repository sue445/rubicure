describe "Cure" do # rubocop:disable RSpec/DescribeClass
  describe ".beat" do
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

  describe ".scarlet" do
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
end
