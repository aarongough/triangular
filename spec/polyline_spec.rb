require 'spec_helper'

RSpec.describe Polyline do
  subject { instance.to_svg(20, 30, :inches, 1, 2) }

  let(:line) { Line.new(Vertex.new(0.0, 0.0, 0.0), Vertex.new(1.0, 1.0, 1.0)) }
  let(:instance) { Polyline.new([line]) }

  describe "#to_svg" do
    let(:expected_svg) do
      expected_svg  = '<?xml version="1.0" standalone="no"?>' + "\n"
      expected_svg += '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">' + "\n"
      expected_svg += '<svg x="0" y="0" width="20in" height="30in" viewBox="0 0 20 30" xmlns="http://www.w3.org/2000/svg" version="1.1">' + "\n"
      expected_svg += '  <g transform="translate(1in,2in)">' + "\n"
      expected_svg += "    #{line.to_svg_path(:inches)}\n"
      expected_svg += '  </g>' + "\n"
      expected_svg += '</svg>'
      expected_svg
    end

    it "should output an SVG document as a string" do
      should == expected_svg
    end
  end
end
