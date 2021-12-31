describe "config/series.yml" do # rubocop:disable RSpec/DescribeClass
  series = Rubicure::Concerns::Util.load_yaml_file("#{spec_dir}/../config/series.yml")

  series.values.uniq {|attributes| attributes["series_name"] }.each do |attributes|
    context attributes["title"] do
      describe "started_date" do
        subject { attributes["started_date"] }

        it { should be_sunday }
      end

      describe "ended_date", if: attributes["ended_date"] do
        subject { attributes["ended_date"] }

        it { should be_sunday }
      end
    end
  end
end
