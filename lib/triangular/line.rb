module Triangular
  class Line
    
    attr_accessor :start, :end
    
    def initialize(line_start, line_end)
      @start = line_start
      @end = line_end
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
      
      if @start.z < @end.z
        low_z = @start.z
        high_z = @end.z
      else
        low_z = @end.z
        high_z = @start.z
      end
      
      if @start.x < @end.x
        low_x = @start.x
        high_x = @end.x
      else
        low_x = @end.x
        high_x = @start.x
      end
      
      if @start.y < @end.y
        low_y = @start.y
        high_y = @end.y
      else
        low_y = @end.y
        high_y = @start.y
      end
      
      percentage_at_intersection = z_plane.to_f / (high_z - low_z)
      
      x_diff = high_x - low_x
      y_diff = high_y - low_y
      
      x_intersect = x_diff * percentage_at_intersection
      y_intersect = y_diff * percentage_at_intersection
      
      Point.new(x_intersect, y_intersect, z_plane)
    end
  end
end
