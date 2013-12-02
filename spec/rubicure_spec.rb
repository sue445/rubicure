require 'spec_helper'

describe Rubicure do
  it 'should have a version number' do
    Rubicure::VERSION.should_not be_nil
  end

  context "when include Rubicure" do
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

          [:happiness_charge],
          [:happiness_charge_precure],
      ]
    end

    with_them do
      it{ expect{ Pretty.cure.send(title) }.not_to raise_error }
    end
  end
end
