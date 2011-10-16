require "bundler/setup"
require "triangular"

solid = Triangular.parse_file("#{File.dirname(__FILE__)}/example_files/y-axis-spacer.stl")
lines = solid.slice_at_z(-0.5)

lines.each do |line|
  puts "#{line.start} : #{line.end}"
end