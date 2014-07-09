require 'bundler'
Bundler::GemHelper.install_tasks
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

desc "Run the specs for Triangular"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = "-c"
  t.fail_on_error = false
  t.verbose = false
end

Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
end

task default: %w[spec features]
