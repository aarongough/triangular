# frozen_string_literal: true

require 'spec_helper'

RSpec.configure do |config|
  config.after(:suite) do
    profile = RubyProf.profile do
      Triangular.parse_file(File.expand_path("#{File.dirname(__FILE__)}/../fixtures/y-axis-spacer.stl"))
    end

    puts "\n\n\n"
    puts '--------------------------------------------------------------------------------'
    puts '-  Profile Results:                                                            -'
    puts '--------------------------------------------------------------------------------'
    puts "\n"

    printer = RubyProf::FlatPrinter.new(profile)
    printer.print($stdout, min_percent: 2)
  end
end
