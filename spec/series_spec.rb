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

      let(:date){ Date.parse("2013-01-01") }

      it{ should be_true }
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
end
