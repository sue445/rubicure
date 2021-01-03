describe Rubicure::Series do
  let(:series_names) do
    [
      :unmarked,
      :max_heart,
      :splash_star,
      :yes,
      :yes_gogo,
      :fresh,
      :heart_catch,
      :suite,
      :smile,
      :dokidoki,
      :happiness_charge,
      :go_princess,
      :maho_girls,
      :a_la_mode,
      :hugtto,
      :star_twinkle,
      :healingood,
    ]
  end

  describe "#on_air?" do
    subject { series.on_air?(date) }

    context "when ended title" do
      let(:series) do
        Rubicure::Series[
            started_date: Date.parse("2012-02-05"),
            ended_date:   Date.parse("2013-01-27"),
        ]
      end

      context "when Date arg" do
        let(:date) { Date.parse("2013-01-01") }

        it { should be true }
      end

      context "when date like String arg" do
        let(:date) { "2013-01-01" }

        it { should be true }
      end
    end

    context "when live title" do
      let(:series) do
        Rubicure::Series[
            started_date: Date.parse("2013-02-03"),
        ]
      end

      let(:date) { Date.parse("2013-12-01") }

      it { should be true }
    end
  end

  describe "#girls" do
    subject { series.girls }

    let(:series) do
      Rubicure::Series[
        girls: %w[cure_happy cure_sunny cure_peace cure_march cure_beauty]
      ]
    end

    it { should have_exactly(5).girls }
    it { should all(be_instance_of Rubicure::Girl) }
  end

  # rubocop:disable Style/CaseEquality, Style/NilComparison
  describe "#===" do
    let(:series) { Rubicure::Series.find(series_name) }
    let(:series_name) { :smile }
    let(:girl) { Rubicure::Girl.find(girl_name) }
    let(:girl_name) { :peace }

    context "same series" do
      let(:same_series) { Rubicure::Series.find(series_name) }

      it { expect(series === same_series).to be true }
      it { expect(series === girl).to be true }
    end

    context "other series" do
      let(:other_series) { Rubicure::Series.find(:dokidoki) }
      let(:other_girl) { Rubicure::Girl.find(:passion) }

      it { expect(series === other_series).to be false }
      it { expect(series === other_girl).to be false }
    end

    context "other ruby object" do
      it { expect(series === Module).to be false }
      it { expect(series === Object.new).to be false }
      it { expect(series === :smile).to be false }
      it { expect(series === true).to be false }
      it { expect(series === nil).to be false }
    end
  end
  # rubocop:enable Style/CaseEquality, Style/NilComparison

  describe "#names" do
    subject { Rubicure::Series.names }

    it { should include(*series_names) }
  end

  describe "#uniq_names" do
    subject { Rubicure::Series.uniq_names }

    it { should include(*series_names) }
    its(:count) { should == series_names.count }
  end

  describe "#find" do
    subject { Rubicure::Series.find(series_name) }

    context "when exists" do
      let(:series_name) { :smile }

      its(:title) { should == "スマイルプリキュア！" }
      its(:girls) { should have_exactly(5).girls }
      its(:series_name) { should eq series_name.to_s }
    end

    context "when not exists" do
      let(:series_name) { :ashita_no_nadja }

      it { expect { subject }.to raise_error Rubicure::UnknownSeriesError }
    end
  end

  describe "#each" do
    subject { series.each }

    let(:series) { Rubicure::Series.find(series_name) }
    let(:series_name) { :splash_star }

    it { expect {|b| series.each(&b) }.to yield_successive_args(Rubicure::Girl, Rubicure::Girl) }
  end

  describe "#to_json" do
    subject { series.to_json }

    let(:series) { Rubicure::Series.find(series_name) }
    let(:series_name) { :splash_star }

    let(:json) do
      <<~JSON
        {\"series_name\":\"splash_star\",\"title\":\"ふたりはプリキュア Splash☆Star\",\"started_date\":\"2006-02-05\",\"ended_date\":\"2007-01-28\",\"girls\":[\"cure_bloom\",\"cure_egret\"]}
      JSON
    end

    it { should eq json.squish }
  end

  describe "#heisei?" do
    subject { series.heisei? }

    using RSpec::Parameterized::TableSyntax

    let(:series) { Rubicure::Series.find(series_name) }

    where(:series_name, :expected) do
      :hugtto       | true
      :star_twinkle | true
    end

    with_them do
      it { should eq expected }
    end
  end

  describe "#reiwa?" do
    subject { series.reiwa? }

    using RSpec::Parameterized::TableSyntax

    let(:series) { Rubicure::Series.find(series_name) }

    where(:series_name, :expected) do
      :hugtto       | false
      :star_twinkle | true
    end

    with_them do
      it { should eq expected }
    end
  end
end
