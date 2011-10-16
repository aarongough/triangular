require 'spec_helper'

describe Polyline do
  describe "#to_svg" do
    it "should output an SVG document as a string" do
      line = Line.new(Vertex.new(0.0, 0.0, 0.0), Vertex.new(1.0, 1.0, 1.0))
      polyline = Polyline.new([line])
      
      expected_svg  = '<?xml version="1.0" standalone="no"?>' + "\n"
      expected_svg += '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">' + "\n"
      expected_svg += '<svg xmlns="http://www.w3.org/2000/svg" version="1.1">' + "\n"
      expected_svg += '  <g transform="translate(200,200)">' + "\n"
      expected_svg += "    #{line.to_svg_path}\n"
      expected_svg += '  </g>' + "\n"
      expected_svg += '</svg>'
      
      polyline.to_svg.should == expected_svg
    end
  end
end