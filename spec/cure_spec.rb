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
end
