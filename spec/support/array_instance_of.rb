require "rspec"

=begin
example)
[1, 2, 3].should array_instance_of Fixnum
=end

RSpec::Matchers.define :array_instance_of do |element_class|
  match do |array|
    array.class == Array && array.all? {|element| element.class == element_class}
  end
end
