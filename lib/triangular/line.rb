# frozen_string_literal: true

module Triangular
  class Line
    attr_accessor :start, :end

    def initialize(line_start, line_end)
      @start = line_start
      @end = line_end
    end

    def ==(other)
      return false unless other.is_a?(Line)

      start == other.start && self.end == other.end
    end

    def intersects_x?(x_plane)
      (@start.x >= x_plane && @end.x <= x_plane) || (@start.x <= x_plane && @end.x >= x_plane)
    end

    def intersection_at_x(x_plane)
      return nil unless intersects_x?(x_plane)
      return nil if @start.x == x_plane && @end.x == x_plane

      y_intersect = (@end.y - @start.y) / (@end.x - @start.x) * (x_plane - @start.x) + @start.y
      z_intersect = (@end.z - @start.z) / (@end.x - @start.x) * (x_plane - @start.x) + @start.z

      Point.new(x_plane, y_intersect, z_intersect)
    end

    def intersects_y?(y_plane)
      (@start.y >= y_plane && @end.y <= y_plane) || (@start.y <= y_plane && @end.y >= y_plane)
    end

    def intersection_at_y(y_plane)
      return nil unless intersects_y?(y_plane)
      return nil if @start.y == y_plane && @end.y == y_plane

      x_intersect = (@end.x - @start.x) / (@end.y - @start.y) * (y_plane - @start.y) + @start.x
      z_intersect = (@end.z - @start.z) / (@end.y - @start.y) * (y_plane - @start.y) + @start.z

      Point.new(x_intersect, y_plane, z_intersect)
    end

    def intersects_z?(z_plane)
      (@start.z >= z_plane && @end.z <= z_plane) || (@start.z <= z_plane && @end.z >= z_plane)
    end

    def intersection_at_z(z_plane)
      return nil unless intersects_z?(z_plane)
      return nil if @start.z == z_plane && @end.z == z_plane

      x_intersect = (@end.x - @start.x) / (@end.z - @start.z) * (z_plane - @start.z) + @start.x
      y_intersect = (@end.y - @start.y) / (@end.z - @start.z) * (z_plane - @start.z) + @start.y

      Point.new(x_intersect, y_intersect, z_plane)
    end

    def to_svg_path(units)
      "<path d=\"M #{@start.x} #{@start.y} L #{@end.x} #{@end.y}\" fill=\"none\" stroke=\"black\" stroke-width=\"#{Units.stroke_width(units)}\" />"
    end
  end
end
