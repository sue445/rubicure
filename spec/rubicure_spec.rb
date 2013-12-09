require 'spec_helper'

describe Rubicure do
  it 'should have a version number' do
    Rubicure::VERSION.should_not be_nil
  end

  describe "#method_missing" do
    context "When Pretty.cure#<title>" do
      where(:title) do
        [
            [:unmarked],
            [:futari_wa_pretty_cure],

            [:max_heart],
            [:futari_wa_pretty_cure_max_heart],

            [:splash_star],
            [:futari_wa_pretty_cure_splash_star],

            [:yes],
            [:yes_precure_five],
            [:yes_precure5],

            [:yes_gogo],
            [:yes_precure_five_gogo],
            [:yes_precure5_gogo],

            [:flesh],
            [:flesh_precure],

            [:heart_catch],
            [:heart_catch_precure],

            [:suite],
            [:suite_precure],

            [:smile],
            [:smile_precure],

            [:dokidoki],
            [:dokidoki_precure],

            #[:happiness_charge],
            #[:happiness_charge_precure],
        ]
      end

      with_them do
        it{ expect{ Pretty.cure.send(title) }.not_to raise_error }
        it{ expect{ Pretty.cure.send(title).girls }.not_to raise_error }
      end
    end

    context "When Pretty.cure#<unmarked_precure_method>" do
      let(:futari_wa_pretty_cure){ Rubicure::Series.find(:unmarked) }

      it{ expect(Pre.cure.title).to       eq futari_wa_pretty_cure.title }
      it{ expect(Pre.cure.girls.count).to eq futari_wa_pretty_cure.girls.count }
    end
  end

  describe "#all_stars" do
    subject{ Pretty.cure.all_stars }

    before do
      @precure_count = 0
      config_file = "#{File.dirname(__FILE__)}/../config/series.yml"
      Pathname(config_file).each_line do |line|
        if !line.start_with?("#") && line.include?("precure_name:")
          @precure_count += 1
        end
      end
    end

    its(:count){ should == @precure_count }
  end
end
