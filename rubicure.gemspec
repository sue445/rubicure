# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubicure/version'

Gem::Specification.new do |spec|
  spec.name          = "rubicure"
  spec.version       = Rubicure::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]
  spec.description   = %q{All about Japanese battle heroine "Pretty Cure (Precure)".}
  spec.summary       = %q{All about Japanese battle heroine "Pretty Cure (Precure)".}
  spec.homepage      = "https://github.com/sue445/rubicure"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4.0.0"
  spec.add_dependency "hashie", ">= 2.0.5"
  spec.add_dependency "sengiri_yaml", ">= 0.0.2"

  spec.add_development_dependency "bundler", ">= 1.3.5"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "delorean"
  spec.add_development_dependency "parser", ">= 2.2.0.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.0.0"
  spec.add_development_dependency "rspec-its", "~> 1.0.1"
  spec.add_development_dependency "rspec-parameterized", "~> 0.1.2"
  spec.add_development_dependency "rubocop", "~> 0.26.1"
  spec.add_development_dependency "yard"
end
