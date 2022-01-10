# frozen_string_literal: true

module Triangular
  class Facet
    attr_accessor :normal, :vertices

    def initialize(normal = nil, *args)
      @normal = normal
      @vertices = args
    end

    def to_s
      output = "facet normal #{@normal}\n"
      output += "outer loop\n"
      @vertices.each do |vertex|
        output += "#{vertex}\n"
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
      return nil if @vertices.count { |vertex| vertex.z == z_plane } > 2

      intersection_points = lines.map do |line|
        line.intersection_at_z(z_plane)
      end.compact

      return Line.new(intersection_points[0], intersection_points[1]) if intersection_points.count == 2

      nil
    end

    def translate!(x, y, z)
      @vertices.each do |vertex|
        vertex.translate!(x, y, z)
      end
    end

    def self.parse(string)
      facets = []

      string.scan(pattern) do |match_data|
        facets << Facet.new(
          Vector.parse(match_data[0]), # Normal
          Vertex.parse(match_data[4]), # Vertex 1
          Vertex.parse(match_data[9]), # Vertex 2
          Vertex.parse(match_data[14]) # Vertex 3
        )
      end

      facets.length == 1 ? facets.first : facets
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
