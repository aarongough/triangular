module Triangular
  class Polyline
   
    attr_accessor :lines
    
    def initialize(lines)
      @lines = lines
    end
    
    def to_svg(x_offset = 20, y_offset = 20)
      output  = '<?xml version="1.0" standalone="no"?>' + "\n"
      output << '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">' + "\n"
      output << '<svg xmlns="http://www.w3.org/2000/svg" version="1.1">' + "\n"
      output << "  <g transform=\"translate(#{x_offset},#{y_offset})\">\n"
      
      @lines.each do |line|
        output << "    " + line.to_svg_path + "\n"
      end
      
      output << '  </g>' + "\n"
      output << '</svg>'
    end
  end
end
