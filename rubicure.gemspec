# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubicure/version"

Gem::Specification.new do |spec|
  spec.name          = "rubicure"
  spec.version       = Rubicure::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]
  spec.description   = 'All about Japanese battle heroine "Pretty Cure (Precure)".'
  spec.summary       = 'All about Japanese battle heroine "Pretty Cure (Precure)".'
  spec.homepage      = "https://github.com/sue445/rubicure"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.0.0"

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create("2.2.2")
    spec.add_dependency "activesupport", ">= 4.0.0"
  else
    # NOTE: activesupport 5.x supports only ruby 2.2.2+
    spec.add_dependency "activesupport", ">= 4.0.0", "< 5.0.0"
  end

  spec.add_dependency "hashie", ">= 2.0.5"
  spec.add_dependency "sengiri_yaml", ">= 0.0.2"

  if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.3.0")
    spec.add_dependency "backport_dig"
  end

  spec.add_development_dependency "bundler", ">= 1.3.5"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "delorean"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "rubocop", "0.35.1"
  spec.add_development_dependency "yard"

  if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.1.0")
    # NOTE: unparser v0.2.5 drop support ruby < 2.1
    spec.add_development_dependency "unparser", "< 0.2.5"
  end
end
