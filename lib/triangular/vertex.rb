# frozen_string_literal: true

require 'forwardable'

module Triangular
  class Vertex
    extend Forwardable

    def_delegator :@point, :x, :x
    def_delegator :@point, :y, :y
    def_delegator :@point, :z, :z
    def_delegator :@point, :translate!, :translate!

    attr_accessor :point

    def initialize(*args)
      if args.length == 1 && args.first.is_a?(Point)
        @point = args.first
      elsif args.length == 3
        @point = Point.new(args[0], args[1], args[2])
      else
        raise 'You must either supply the XYZ coordinates or a Point object to create a Vertex'
      end
    end

    def to_s
      "vertex #{@point}"
    end

    def ==(other)
      return false unless other.is_a?(Vertex)

      x == other.x && y == other.y && z == other.z
    end

    def self.parse(string)
      match_data = string.strip.match(pattern)

      new(Point.parse(match_data[:point]))
    end

    def self.pattern
      /vertex\s+ (?<point>#{Point.pattern})/x
    end
  end
end
