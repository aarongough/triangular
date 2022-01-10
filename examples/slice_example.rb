# frozen_string_literal: true

require 'bundler/setup'
require 'triangular'

solid = Triangular.parse_file("#{File.dirname(__FILE__)}/example_files/y-axis-spacer.stl")
solid.units = :inches

solid.align_to_origin!
bounds = solid.get_bounds

polyline = solid.slice_at_z(0.7)

File.open(File.expand_path('~/Desktop/slice.svg'), 'w+') do |file|
  file.puts polyline.to_svg(bounds[1].x, bounds[1].y, solid.units)
end
