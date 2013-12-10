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

  it "output all precure methods" do
    Rubicure::Series.names.each do |series_name|
      puts "[#{series_name}] ===================="
      series = Rubicure::Series.find(series_name)
      puts <<EOS
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
  transform_message:
#{girl.transform_message}
EOS
      end
    end
  end
end
