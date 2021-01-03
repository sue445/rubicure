source "https://rubygems.org"

# Specify your gem's dependencies in rubicure.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # activesupport v6.0.0+ requires Ruby 2.5.0+
  gem "activesupport", "< 6.0.0"
end
