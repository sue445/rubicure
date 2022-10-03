require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "Run rubydoctest"
task :rubydoctest do
  sh "rubydoctest README.md"
end

desc "Run tests"
task :test => [:spec, :rubydoctest]

task :default => :test

require "yard"

YARD::Rake::YardocTask.new
