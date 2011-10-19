require 'spec_helper'

describe Units do
  describe ".name" do
    it "should return 'inches' for :inches" do
      Units.name(:inches).should == 'inches'
    end
    
    it "should return 'centimeters' for :centimeters" do
      Units.name(:centimeters).should == 'centimeters'
    end
    
    it "should return 'millimeters' for :millimeters" do
      Units.name(:millimeters).should == 'millimeters'
    end
    
    it "should return 'none' for :none" do
      Units.name(:none).should == 'none'
    end
    
    it "should raise an exception if called with an unknown unit" do
      lambda {
        Units.name(:error)
      }.should raise_error
    end
  end
  
  describe ".svg_name" do
    it "should return 'in' for :inches" do
      Units.svg_name(:inches).should == 'in'
    end
    
    it "should return 'cm' for :centimeters" do
      Units.svg_name(:centimeters).should == 'cm'
    end
    
    it "should return 'mm' for :millimeters" do
      Units.svg_name(:millimeters).should == 'mm'
    end
    
    it "should return '' for :none" do
      Units.svg_name(:none).should == ''
    end
    
    it "should raise an exception if called with an unknown unit" do
      lambda {
        Units.svg_name(:error)
      }.should raise_error
    end
  end
  
  describe ".stroke_width" do
    it "should return 'in' for :inches" do
      Units.stroke_width(:inches).should == 0.005
    end
    
    it "should return 'cm' for :centimeters" do
      Units.stroke_width(:centimeters).should == 0.01
    end
    
    it "should return 'mm' for :millimeters" do
      Units.stroke_width(:millimeters).should == 0.1
    end
    
    it "should return '' for :none" do
      Units.stroke_width(:none).should == 0.1
    end
    
    it "should raise an exception if called with an unknown unit" do
      lambda {
        Units.stroke_width(:error)
      }.should raise_error
    end
  end
end