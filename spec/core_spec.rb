describe Rubicure::Core do
  let(:instance){ Rubicure::Core.instance }

  describe "#names" do
    subject{ instance.series_names }

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

  describe "#fetch" do
    subject(:series){ instance.fetch(series_name) }

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
    instance.series_names.each do |series_name|
      puts "[#{series_name}] ===================="
      series = Rubicure.core[series_name]
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
