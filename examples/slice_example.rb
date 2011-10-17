require "bundler/setup"
require "triangular"

solid = Triangular.parse_file("#{File.dirname(__FILE__)}/example_files/y-axis-spacer.stl")
polyline = solid.slice_at_z(-0.5)

File.open(File.expand_path("~/Desktop/slice.svg"), "w+") do |file|
  file.puts polyline.to_svg(10, 10)
end