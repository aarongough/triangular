require 'spec_helper'

describe Solid do
  describe ".parse" do
    context "with a correctly formatted solid" do
      before do
        @result = Solid.parse(<<-EOD)
          solid y-axis-spacer
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
          facet normal -0.0 1.0 0.0
          outer loop
          vertex 0.0 -1.87 0.0
          vertex 16.5 -1.87 -0.13
          vertex 0.0 -1.87 -0.13
          endloop
          endfacet
          endsolid y-axis-spacer
          
        EOD
      end
      
      it "should return a Solid" do
        expect(@result).to be_a Solid
      end
      
      it "should correctly set the name parameter" do
        expect(@result.name).to eq("y-axis-spacer")
      end
      
      it "should retun a Solid that has two Facets" do
        expect(@result.facets.length).to eq(2)
      end
      
      it "should return a Solid that has facets of type Facet" do
        @result.facets.each do |facet|
          expect(facet).to be_a Facet
        end
      end
    end
  end
  
  describe "#to_s" do
    it "should output a string representation exactly the same as the input" do
      input  = "solid y-axis-spacer\n"
      input += "facet normal 0.0 0.0 -1.0\n"
      input += "outer loop\n"
      input += "vertex 16.5 0.0 -0.75\n"
      input += "vertex 0.0 -9.5 -0.75\n"
      input += "vertex 0.0 0.0 -0.75\n"
      input += "endloop\n"
      input += "endfacet\n"
      input += "facet normal -0.0 1.0 0.0\n"
      input += "outer loop\n"
      input += "vertex 0.0 -1.87 0.0\n"
      input += "vertex 16.5 -1.87 -0.13\n"
      input += "vertex 0.0 -1.87 -0.13\n"
      input += "endloop\n"
      input += "endfacet\n"
      input += "endsolid y-axis-spacer\n"
      
      solid = Solid.parse(input)
      output = solid.to_s
      
      expect(output).to eq(input)
    end
  end
  
  describe "#slice_at_z" do
    before do
      @solid = Solid.parse(File.open("#{File.dirname(__FILE__)}/fixtures/test_cube.stl").read)
    end

    it "should return a Polyline" do
      expect(@solid.slice_at_z(0)).to be_a Polyline
    end
  end
  
  describe "#get_bounds" do
    before do
      @solid = Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 -0.75
        vertex 0.0 -9.5 -0.75
        vertex 0.0 0.0 -0.75
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 0.0
        vertex 16.5 -1.87 -0.13
        vertex 0.0 1.87 -0.13
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    it "should return an array" do
      expect(@solid.get_bounds).to be_a Array
    end
    
    it "should return a point with the smallest bounds" do
      expect(@solid.get_bounds[0].x).to eq(-16.5)
      expect(@solid.get_bounds[0].y).to eq(-9.5)
      expect(@solid.get_bounds[0].z).to eq(-0.75)
    end
    
    it "should return a point with the largest bounds" do
      expect(@solid.get_bounds[1].x).to eq(16.5)
      expect(@solid.get_bounds[1].y).to eq(1.87)
      expect(@solid.get_bounds[1].z).to eq(0.0)
    end
  end
  
  describe "#translate!" do
    before do
      @solid = Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 -0.75
        vertex 0.0 -9.5 -0.75
        vertex 0.0 0.0 -0.75
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 0.0
        vertex 16.5 -1.87 -0.13
        vertex 0.0 1.87 -0.13
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    it "should call translate on each of it's Facets" do
      expect(@solid.facets[0]).to receive(:translate!).with(16.5, 9.5, 0.75)
      expect(@solid.facets[1]).to receive(:translate!).with(16.5, 9.5, 0.75)
      
      @solid.translate!(16.5, 9.5, 0.75)
    end
  end
  
  describe "#align_to_origin!" do
    before do
      @solid = Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 5.0
        vertex 0.0 -9.5 10.0
        vertex 0.0 0.0 5.0
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 5.0
        vertex 16.5 -1.87 11.0
        vertex 0.0 1.87 6.0
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    it "should translate solid so the lowermost XYZ edges are all 0.0" do
      expect(@solid).to receive(:translate!).with(16.5, 9.5, -5.0)
      @solid.align_to_origin!
    end
  end
  
  describe "#center!" do
    before do
      @solid = Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 5.0
        vertex 0.0 -9.5 10.0
        vertex 0.0 0.0 5.0
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 5.0
        vertex 17.5 -1.87 11.0
        vertex 0.0 1.5 6.0
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    it "should translate solid so the lowermost XYZ edges are all 0.0" do
      expect(@solid).to receive(:translate!).with(-0.5, 4.0, -8.0)
      @solid.center!
    end
  end
end