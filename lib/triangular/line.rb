module Triangular
  class Line
    
    attr_accessor :start, :end
    
    def initialize(line_start, line_end)
      @start = line_start
      @end = line_end
    end
    
    def ==(other)
      return false unless other.is_a?(Line)
      self.start == other.start && self.end == other.end
    end
    
    def intersects_z?(z_plane)
      if (@start.z >= z_plane && @end.z <= z_plane) || (@start.z <= z_plane && @end.z >= z_plane)
        true
      else
        false
      end
    end
    
    def intersection_at_z(z_plane)
      return nil if !self.intersects_z?(z_plane)
      raise "Cannot calculate intersection for line that lies on the target Z plane" if @start.z == z_plane && @end.z == z_plane
      
      x_intersect = (@end.x - @start.x) / (@end.z - @start.z) * (z_plane - @start.z) + @start.x
      y_intersect = (@end.y - @start.y) / (@end.z - @start.z) * (z_plane - @start.z) + @start.y
      
      Point.new(x_intersect, y_intersect, z_plane)
    end
  end
end
