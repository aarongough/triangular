module Triangular
  class Polyline
    attr_accessor :lines

    def initialize(lines)
      @lines = lines
    end

    def to_svg(width, height, units, x_offset = 0, y_offset = 0)
      output = '<?xml version="1.0" standalone="no"?>' + "\n"
      output << '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">' + "\n"
      output << "<svg x=\"0\" y=\"0\" width=\"#{width}#{Units.svg_name(units)}\" height=\"#{height}#{Units.svg_name(units)}\" viewBox=\"0 0 #{width} #{height}\" xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">\n"
      output << "  <g transform=\"translate(#{x_offset}#{Units.svg_name(units)},#{y_offset}#{Units.svg_name(units)})\">\n"

      @lines.each do |line|
        output << '    ' + line.to_svg_path(units) + "\n"
      end

      output << '  </g>' + "\n"
      output << '</svg>'
    end
  end
end
