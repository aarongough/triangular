require "simplecov"
SimpleCov.start

require "bundler/setup"
require "triangular"
require "benchmark"
require "ruby-prof"

include Triangular

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    $benchmarks = {}
  end

  config.after(:suite) do
    puts "\n\nBenchmark Results:"
    $benchmarks.each do |test_name, result|
      puts test_name.ljust(34) + ": " + result.to_s
    end

    puts "\n\nProfile Results:"
    printer = RubyProf::FlatPrinter.new($profile)
    printer.print(STDOUT, :min_percent => 2)
  end
end
