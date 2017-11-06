require 'forwardable'

module Triangular
  class UnknownUnitError < RuntimeError; end

  class Units

    UNITS = {
      :inches      => {:name => 'inches', :svg_name => 'in', :stroke_width => 0.005},
      :centimeters => {:name => 'centimeters', :svg_name => 'cm', :stroke_width => 0.01},
      :millimeters => {:name => 'millimeters', :svg_name => 'mm', :stroke_width => 0.1},
      :none        => {:name => 'none', :svg_name => '', :stroke_width => 0.1}
    }

    def self.get_property(unit, name)
      raise UnknownUnitError.new("Unknown unit: #{unit}") unless UNITS.has_key?(unit)
      UNITS[unit][name]
    end

    def self.name(unit)
      self.get_property(unit, :name)
    end

    def self.svg_name(unit)
      self.get_property(unit, :svg_name)
    end

    def self.stroke_width(unit)
      self.get_property(unit, :stroke_width)
    end
  end
end
