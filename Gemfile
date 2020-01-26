source "https://rubygems.org"

# Specify your gem's dependencies in rubicure.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.3.0")
  gem "backport_dig"

  # i18n v1.5.1+ requires Ruby 2.3.0+
  gem "i18n", "< 1.5.1"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # activesupport v6.0.0+ requires Ruby 2.5.0+
  gem "activesupport", "< 6.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.4.0")
  # byebug v11.0.0+ requires Ruby 2.3.0+ and byebug v11.1.0+ requires Ruby 2.4.0+
  gem "byebug", "< 11.0.0"
end
