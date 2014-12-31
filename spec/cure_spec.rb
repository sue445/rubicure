describe "Cure" do
  describe ".peace" do
    describe "#pikarin_janken" do
      subject{ girl.pikarin_janken }

      shared_examples :do_janken do
        it{ should match %r/ピカピカピカリン\nジャンケンポン！\n（.+）/ }
      end

      context "When peace" do
        let(:girl){ Cure.peace }
        it_behaves_like :do_janken
      end

      context "When cure_peace" do
        let(:girl){ Cure.cure_peace }
        it_behaves_like :do_janken
      end
    end
  end

  describe ".passion" do
    describe "!" do
      subject{ !Cure.passion }

      let(:girl){ Cure.passion }

      after do
        girl.rollback
        girl.humanize!
      end

      context "called once" do
        it{ expect{ subject }.to change{ girl.name }.from("東せつな").to("イース") }
      end

      context "called twice" do
        before do
          !Cure.passion
        end

        it{ expect{ subject }.to change{ girl.name }.from("イース").to("東せつな") }
      end

      context "after transform" do
        before do
          girl.transform!
        end

        it{ expect{ subject }.to change{ girl.name }.from("キュアパッション").to("イース") }
      end
    end
  end

  describe ".beat" do
    describe "!" do
      subject{ !Cure.beat }

      let(:girl){ Cure.beat }

      after do
        girl.rollback
        girl.humanize!
      end

      context "called once" do
        it{ expect{ subject }.to change{ girl.name }.from("黒川エレン").to("セイレーン") }
      end

      context "called twice" do
        before do
          !Cure.beat
        end

        it{ expect{ subject }.to change{ girl.name }.from("セイレーン").to("黒川エレン") }
      end

      context "after transform" do
        before do
          girl.transform!
        end

        it{ expect{ subject }.to change{ girl.name }.from("キュアビート").to("セイレーン") }
      end
    end
  end
end
