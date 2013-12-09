describe Rubicure::Series do
  describe "#on_air?" do
    subject{ series.on_air?(date) }

    context "when ended title" do
      let(:series) {
        Rubicure::Series[
            started_date: Date.parse("2012-02-05"),
            ended_date:   Date.parse("2013-01-27"),
        ]
      }

      context "when Date arg" do
        let(:date){ Date.parse("2013-01-01") }

        it{ should be_true }
      end

      context "when date like String arg" do
        let(:date){ "2013-01-01" }

        it{ should be_true }
      end
    end

    context "when live title" do
      let(:series) {
        Rubicure::Series[
            started_date: Date.parse("2013-02-03"),
        ]
      }

      let(:date){ Date.parse("2013-12-01") }

      it{ should be_true }
    end
  end

  describe "#girls" do
    subject{ series.girls }

    let(:series) {
      Rubicure::Series[
        girls: [
            {
                human_name:        "黄瀬やよい",
                precure_name:      "キュアピース",
                transform_message: "",
                extra_names:       []
            },
            {
                human_name:        "星空みゆき",
                precure_name:      "キュアハッピー",
                transform_message: "",
                extra_names:       []
            },
        ]
      ]
    }

    it{ should have_exactly(2).girls }
    its([0]){ should be_an_instance_of Rubicure::Girl }
  end

  describe "#names" do
    subject{ Rubicure::Series.names }

    where(:series_name) do
      [
          [:unmarked],
          [:max_heart],
          [:splash_star],
          [:yes],
          [:yes_gogo],
          [:flesh],
          [:heart_catch],
          [:suite],
          [:smile],
          [:dokidoki],
      #[:happiness_charge],
      ]
    end

    with_them do
      it{ should include series_name }
    end
  end

  describe "#find" do
    subject(:series){ Rubicure::Series.find(series_name) }

    context "when exists" do
      let(:series_name){ :smile }

      it{ expect(series.title).to eq "スマイルプリキュア！" }
      it{ expect(series.girls.count).to eq 5 }
    end

    context "when not exists" do
      let(:series_name){ :ashita_no_nadja  }

      it{ expect{subject}.to raise_error }
    end
  end

end
