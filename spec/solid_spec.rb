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
        @result.should be_a Solid
      end
      
      it "should correctly set the name parameter" do
        @result.name.should == "y-axis-spacer"
      end
      
      it "should retun a Solid that has two Facets" do
        @result.facets.length.should == 2
      end
      
      it "should return a Solid that has facets of type Facet" do
        @result.facets.each do |facet|
          facet.should be_a Facet
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
      
      output.should == input
    end
  end
end