# frozen_string_literal: true

require 'spec_helper'

RSpec.configure do |config|
  config.after(:suite) do
    benchmarks = {}

    benchmarks['Triangular.parse_file'] = Benchmark.measure do
      Triangular.parse_file(File.expand_path("#{File.dirname(__FILE__)}/../fixtures/y-axis-spacer.stl"))
    end

    puts "\n\n\n"
    puts '--------------------------------------------------------------------------------'
    puts '-  Benchmark Results:                                                          -'
    puts '--------------------------------------------------------------------------------'
    puts "\n"

    benchmarks.each do |test_name, result|
      puts test_name.ljust(34) + ": #{result}"
    end
  end
end
