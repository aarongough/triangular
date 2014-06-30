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
    
    def lines
      [
        Line.new(@vertices[0], @vertices[1]),
        Line.new(@vertices[1], @vertices[2]),
        Line.new(@vertices[2], @vertices[0])
      ]
    end
    
    def intersection_at_z(z_plane)
      return nil if @vertices.count{|vertex| vertex.z == z_plane} > 2
      
      intersection_points = []
      lines.each do |line|
        intersection_points << line.intersection_at_z(z_plane)
      end
      
      intersection_points.compact!
      if intersection_points.empty?
        nil
      elsif intersection_points.count == 2       
        Line.new(intersection_points[0], intersection_points[1])
      end
    end
    
    def translate!(x, y, z)
      @vertices.each do |vertex|
        vertex.translate!(x, y, z)
      end
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

  def to_inc
    lines = ['triangle {']
    vertices.each.with_index do |v, i|
      text = "<#{v.x}, #{v.y}, #{v.z}>"
      text = "  " + text
      text << ',' unless i == vertices.length - 1
      lines << text
    end
    lines << '}'
    lines.join("\n") + "\n"
  end
end
