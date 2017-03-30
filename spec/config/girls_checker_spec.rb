describe "girls_checker" do
  config_files = Pathname.glob("#{spec_dir}/../config/girls/*.yml")

  config_files.each do |config_file|
    describe "config/girls/#{config_file.basename}" do
      girls = YAML.load_file(config_file)

      girls.each do |girl_name, girl|
        describe girl_name do
          describe "#transform_message" do
            subject { girl["transform_message"] }

            it { should_not end_with("\n") }
          end

          describe "#attack_messages" do
            it "should not all end with(\\n)" do
              aggregate_failures do
                Array(girl["attack_messages"]).each do |attack_message|
                  # NOTE: `expect().not_to all( matcher )` is not supported.
                  expect(attack_message).not_to end_with("\n")
                end
              end
            end
          end
        end
      end
    end
  end
end
