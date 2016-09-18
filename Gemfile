source "https://rubygems.org"

# Specify your gem's dependencies in rubicure.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.1.0")
  # NOTE: build is failed when use ruby 2.0 and rspec-parameterized 0.3.0+
  #   https://travis-ci.org/sue445/rubicure/jobs/114266855
  gem "rspec-parameterized", "< 0.3.0", group: :test
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.1.0")
  # NOTE: unparser v0.2.5 drop support ruby < 2.1
  gem "unparser", "< 0.2.5", group: :test
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.2")
  # NOTE: activesupport 5.x supports only ruby 2.2.2+
  gem "activesupport", ">= 4.0.0", "< 5.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.3.0")
  gem "backport_dig"
end
