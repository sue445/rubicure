describe Rubicure::Core do
  let(:instance) { Rubicure::Core.instance }

  describe "#now" do
    subject { instance.now }

    context "when on air" do
      before do
        time_travel_to "2013-01-01"
      end

      its(:title) { should == "スマイルプリキュア！" }
    end

    context "when not on air" do
      before do
        time_travel_to "2013-02-01"
      end

      it { expect { subject }.to raise_error Rubicure::NotOnAirError }
    end
  end

  it "output all precure methods", category: :verbose do
    Precure.each_with_series do |series|
      puts <<EOS
====================
title:     #{series.title}
broadcast: #{series.started_date} - #{series.try(:ended_date)}
girls:     #{series.girls.count}
EOS

      series.girls.each do |girl|
        puts <<EOS
------------------------
  human_name:   #{girl.human_name}
  precure_name: #{girl.precure_name}
  cast_name:    #{girl.cast_name}
  color:        #{girl.color}
  extra_names:  #{girl[:extra_names]}
  state_names:  #{girl.state_names}
  attack_messages: #{girl.attack_messages}
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

    it { expect { |b| instance.each_with_series(&b) }.to yield_successive_args(*@expected_series) }
  end

  describe "#all_stars" do
    context "Without arg" do
      subject { instance.all_stars }

      let(:precure_count) { 44 }

      its(:count) { should == precure_count }
    end

    context "With arg" do
      subject { instance.all_stars(arg) }

      where(:arg, :expected_count, :include_cure_echo) do
        [
          ["2009-03-20",             14, false],
          [Date.parse("2010-03-20"), 17, false],
          [Time.parse("2011-03-19"), 21, false],

          [:dx,         14, false],
          [:dx1,        14, false],
          [:dx2,        17, false],
          [:dx3,        21, false],

          [:ns,         29, true],
          [:ns1,        29, true],
          [:new_stage,  29, true],
          [:new_stage1, 29, true],
          [:ns2,        32, false],
          [:new_stage2, 32, false],
          [:ns3,        37, true],
          [:new_stage3, 37, true],

          [:sc,              40, false],
          [:spring_carnival, 40, false],

          [:stmm,                        44, true],
          [:sing_together_miracle_magic, 44, true],
        ]
      end

      with_them do
        its(:count) { should == expected_count }
        it { expect(subject.include?(Cure.echo)).to be include_cure_echo }
      end
    end
  end
end
