require 'spec_helper'

describe Vertex do
  describe ".parse" do
    context "with a correctly formatted vertex" do
      before do
        @result = Vertex.parse("  vertex 16.5 0.0 -0.75\n")
      end
      
      it "should return a vertex object" do
        @result.should be_a Vertex
      end
      
      it "should correctly set the X value" do
        @result.x.should == 16.5
      end
      
      it "should correctly set the Y value" do
        @result.y.should == 0
      end
      
      it "should correctly set the Z value" do
        @result.z.should == -0.75
      end
    end
  end
end