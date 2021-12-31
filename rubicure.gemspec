lib = File.expand_path("lib", __dir__)
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

  spec.required_ruby_version = ">= 2.6"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
    spec.metadata["rubygems_mfa_required"] = "true"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)

  %w[examples/].each do |exclude_dir|
    spec.files.reject! {|filename| filename.start_with?(exclude_dir) }
  end

  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.0.0"
  spec.add_dependency "hashie", ">= 2.0.5"
  spec.add_dependency "sengiri_yaml", ">= 1.0.0"

  spec.add_development_dependency "bundler", ">= 1.3.5"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "delorean"
  spec.add_development_dependency "onkcop", "1.0.0.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.8.0"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-parameterized", ">= 0.3.2"
  spec.add_development_dependency "rubocop", "1.24.0"
  spec.add_development_dependency "rubocop_auto_corrector"
  spec.add_development_dependency "rubocop-performance", "1.9.2"
  spec.add_development_dependency "rubocop-rake", "0.5.1"
  spec.add_development_dependency "rubocop-rspec", "2.1.0"
  spec.add_development_dependency "rubydoctest"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "unparser", ">= 0.4.5"
  spec.add_development_dependency "yard"
end
