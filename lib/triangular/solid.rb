module Triangular
  class Solid
    
    attr_accessor :name, :facets
    
    def initialize(name, *args)
      @name = name
      @facets = args
    end
    
    def to_s
      output = "solid #{@name || ""}\n"
      @facets.each do |facet|
        output << "facet normal #{facet.normal.x.to_f} #{facet.normal.y.to_f} #{facet.normal.z.to_f}\n"
        output << "outer loop\n"
        facet.vertices.each do |vertex|
          output <<"vertex #{vertex.x.to_f} #{vertex.y.to_f} #{vertex.z.to_f}\n"
        end
        output << "endloop\n"
        output << "endfacet\n"
      end
      output << "endsolid #{@name || ""}\n"
      
      output
    end
    
    def slice_at_z(z_plane)
      lines = @facets.map {|facet| facet.intersection_at_z(z_plane) }
      lines.compact!
      
      Polyline.new(lines)
    end
    
    def self.parse(string)
      partial_pattern = /\s* solid\s+ (?<name> [a-zA-Z0-9\-\_\.]+)?/x
      match_data = string.match(partial_pattern)
      
      solid = self.new(match_data[:name])
      
      solid.facets = Facet.parse(string.gsub(partial_pattern, ""))
      
      solid
    end
  end
end
