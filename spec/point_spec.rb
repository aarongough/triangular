require 'spec_helper'

describe Point do
  describe ".parse" do
    context "with a correctly formatted point" do
      before do
        @result = Point.parse("  16.5 0.0 -0.75 ")
      end
      
      it "should return a point object" do
        @result.should be_a Point
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