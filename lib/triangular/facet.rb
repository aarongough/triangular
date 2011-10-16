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
      match_data = string.match(self.pattern)
      
      facet = self.new
      
      facet.vertices << Vertex.parse(match_data[:vertex1])
      facet.vertices << Vertex.parse(match_data[:vertex2])
      facet.vertices << Vertex.parse(match_data[:vertex3])
      
      facet.normal = Vector.parse(match_data[:normal])
      
      facet
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
