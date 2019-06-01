describe Rubicure::Concerns::Gengou do
  using Rubicure::Concerns::Gengou

  describe "Date#heisei?" do
    subject { date(str).heisei? }

    using RSpec::Parameterized::TableSyntax

    where(:str, :expected) do
      "1989-01-07" | false
      "1989-01-08" | true
      "2019-04-30" | true
      "2019-05-01" | false
    end

    with_them do
      it { should eq expected }
    end
  end

  describe "Date#reiwa?" do
    subject { date(str).reiwa? }

    using RSpec::Parameterized::TableSyntax

    where(:str, :expected) do
      "1989-01-07" | false
      "1989-01-08" | false
      "2019-04-30" | false
      "2019-05-01" | true
    end

    with_them do
      it { should eq expected }
    end
  end
end
