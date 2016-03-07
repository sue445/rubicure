source "https://rubygems.org"

# Specify your gem's dependencies in rubicure.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.1.0")
  # NOTE: build is failed when use ruby 2.0 and rspec-parameterized 0.3.0+
  #   https://travis-ci.org/sue445/rubicure/jobs/114266855
  gem "rspec-parameterized", "< 0.3.0"
end
