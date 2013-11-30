describe Rubicure::Series do
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
          [:happiness_charge],
      ]
    end

    with_them do
      it{ should include series_name }
    end
  end
end
