module Triangular
  class Facet
    
    attr_accessor :normal, :vertices
    
    def initialize(normal = nil, *args)
      @normal = normal
      @vertices = args
    end
    
    def to_s
      output = "facet normal #{@normal.to_s}\n"
      output += "outer loop\n"
      @vertices.each do |vertex|
        output += vertex.to_s + "\n"
      end
      output += "endloop\n"
      output += "endfacet\n"
      
      output
    end
    
    def self.parse(string)
      facets = []
      
      string.scan(self.pattern) do |match_data|
        facet = self.new
        
        facet.vertices << Vertex.parse(match_data[4])
        facet.vertices << Vertex.parse(match_data[9])
        facet.vertices << Vertex.parse(match_data[14])
        
        facet.normal = Vector.parse(match_data[0])
        
        facets << facet
      end
      
      if facets.length == 1
        facets.first
      else
        facets
      end
    end
    
    def self.pattern
      /
      \s* facet\snormal\s (?<normal> #{Point.pattern})\s
      \s* outer\sloop\s
      \s* (?<vertex1> #{Vertex.pattern})
      \s* (?<vertex2> #{Vertex.pattern})
      \s* (?<vertex3> #{Vertex.pattern})
      \s* endloop\s
      \s* endfacet\s
      /x
    end
  end
end
