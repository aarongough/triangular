require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

desc "Run the specs for Triangular"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = "-c"
  t.fail_on_error = false
  t.verbose = false
end