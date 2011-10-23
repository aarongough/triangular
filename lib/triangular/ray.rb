module Triangular
  class Ray
    
    attr_accessor :x, :y
    
    def initialize(x, y)
      @x = x
      @y = y
    end
    
    def intersection(facet)
      lines = facet.lines
      
      x_intersection = false
      y_intersection = false
      
      lines.each do |line|
        x_intersection = true if line.start.x <= @x && line.end.x >= @x
        x_intersection = true if line.end.x <= @x && line.start.x >= @x
        
        y_intersection = true if line.start.y <= @y && line.end.y >= @y
        y_intersection = true if line.end.y <= @y && line.start.y >= @y
      end
      
      return nil unless x_intersection && y_intersection
      
      x_intersections = lines.map do |line|
        line.intersection_at_x(@x)
      end
      
      x_intersections.compact!
      
      if x_intersections[0] == x_intersections[1]
        x_intersections[0]
      else
        Line.new(x_intersections[0], x_intersections[1]).intersection_at_y(@y)
      end
    end
    
  end
end