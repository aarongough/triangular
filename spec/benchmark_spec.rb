require 'spec_helper'

describe 'benchmark' do
  it 'benchmarks parsing a file' do
    $benchmarks['Triangular.parse_file'] = Benchmark.measure do
      Triangular.parse_file(File.expand_path("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl"))
    end
  end
end
