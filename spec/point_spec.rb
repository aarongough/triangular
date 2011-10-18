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
    
    context "with a point that contains exponential notation" do
      before do
        @result = Point.parse("  -5.23431439438796e-32 0.0 5.23431439438796e32 ")
      end
      
      it "should correctly set the X value" do
        @result.x.should == -5.23431439438796e-32
      end
      
      it "should correctly set the Y value" do
        @result.y.should == 0.0
      end
      
      it "should correctly set the Z value" do
        @result.z.should == 5.23431439438796e32
      end
    end
  end
  
  describe "#to_s" do
    it "should return the XYZ components separated by spaces" do
      point = Point.new(1.0, 2.0, -3.1)
      point.to_s.should == "1.0 2.0 -3.1"
    end
    
    it "should convert integers into floats for output" do
      point = Point.new(1, 2, 3)
      point.to_s.should == "1.0 2.0 3.0"
    end
  end
  
  describe "#==" do
    it "should return true when the points have identical values" do
      (Point.new(1.0, 2.0, -3.1) == Point.new(1.0, 2.0, -3.1)).should be_true
    end
    
    it "should return false when the points do not have identical values" do
      (Point.new(1.0, 2.0, -3.1) == Point.new(1.0, 2.0, -3.2)).should be_false
    end
  end
  
  describe "#translate!" do
    before do
      @point = Point.new(1.0, 1.0, 1.0)
    end
    
    it "should add the supplied value to X" do
      @point.translate!(16.5, 9.5, 0.75)
      @point.x.should == 17.5
    end
    
    it "should add the supplied value to Y" do
      @point.translate!(16.5, 9.5, 0.75)
      @point.y.should == 10.5
    end
    
    it "should add the supplied value to Z" do
      @point.translate!(16.5, 9.5, 0.75)
      @point.z.should == 1.75
    end
  end
end