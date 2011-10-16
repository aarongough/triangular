module Triangular
  class Vertex
    extend Forwardable
    
    def_delegator :@point, :x, :x
    def_delegator :@point, :y, :y
    def_delegator :@point, :z, :z
    
    def initialize(*args)
      if args.length == 1 && args.first.is_a?(Point)
        @point = args.first
      elsif args.length == 3
        @point = Point.new(args[0], args[1], args[2])      
      else
        raise "You must either supply the XYZ coordinates or a Point object to create a Vertex"
      end
    end
    
    def to_s
      "vertex #{@point.to_s}"
    end
    
    def ==(other)
      return false unless other.is_a?(Vertex)
      self.x == other.x && self.y == other.y && self.z == other.z
    end
    
    def self.parse(string)
      string.strip!
      match_data = string.match(self.pattern)
      
      self.new(Point.parse(match_data[:point]))
    end
    
    def self.pattern
      /vertex\s+ (?<point>#{Point.pattern})/x
    end
    
  end
end
