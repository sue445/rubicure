describe "girls_checker" do # rubocop:disable RSpec/DescribeClass
  config_files = Pathname.glob("#{spec_dir}/../config/girls/*.yml")

  config_files.each do |config_file|
    describe "config/girls/#{config_file.basename}" do
      girls = Rubicure::Concerns::Util.load_yaml_file(config_file)

      girls.each do |girl_name, girl|
        describe girl_name do
          describe "#transform_message" do
            subject { girl["transform_message"] }

            it { should_not end_with("\n") }
          end

          describe "#attack_messages" do
            it "does not all end with(\\n)" do
              aggregate_failures do
                Array(girl["attack_messages"]).each do |attack_message|
                  # NOTE: `expect().not_to all( matcher )` is not supported.
                  expect(attack_message).not_to end_with("\n")
                end
              end
            end
          end

          describe "#birthday" do
            context "has birthday", if: girl.has_key?("birthday") do
              birthday = girl["birthday"]

              it { expect(birthday).not_to be_blank }

              it "'#{birthday}' is valid date" do
                ymd = "#{Date.today.year}/#{birthday}"
                expect(Date.parse(ymd)).to be_a Date
              end
            end
          end
        end
      end
    end
  end
end
