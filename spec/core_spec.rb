describe Rubicure::Core do
  let(:instance){ Rubicure::Core.instance }

  describe "#now" do
    subject{ instance.now }

    context "when on air" do
      before do
        time_travel_to "2013-01-01"
      end

      its(:title){ should == "スマイルプリキュア！" }
    end

    context "when not on air" do
      before do
        time_travel_to "2013-02-01"
      end

      it{ expect{ subject }.to raise_error }
    end
  end

  it "output all precure methods", category: :verbose do
    Precure.each_with_series do |series|
      puts <<EOS
====================
title:     #{series.title}
broadcast: #{series.started_date} - #{series.ended_date}
girls:     #{series.girls.count}
EOS

      series.girls.each do |girl|
        puts <<EOS
------------------------
  human_name:   #{girl.human_name}
  precure_name: #{girl.precure_name}
  extra_names:  #{girl.extra_names}
  state_names:  #{girl.state_names}
  transform_message:
#{girl.transform_message}
EOS
      end
    end
  end

  describe "#each_with_series" do
    before do
      @expected_series = []
      Rubicure::Series.uniq_names.each do |series_name|
        @expected_series << Rubicure::Series.find(series_name)
      end
    end

    it{ expect{|b| instance.each_with_series(&b) }.to yield_successive_args *@expected_series }
  end
end
