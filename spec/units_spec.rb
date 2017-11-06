require 'spec_helper'

describe Units do
  describe ".name" do
    it "should return 'inches' for :inches" do
      expect(Units.name(:inches)).to eq('inches')
    end
    
    it "should return 'centimeters' for :centimeters" do
      expect(Units.name(:centimeters)).to eq('centimeters')
    end
    
    it "should return 'millimeters' for :millimeters" do
      expect(Units.name(:millimeters)).to eq('millimeters')
    end
    
    it "should return 'none' for :none" do
      expect(Units.name(:none)).to eq('none')
    end
    
    it "should raise an exception if called with an unknown unit" do
      expect {
        Units.name(:error)
      }.to raise_error
    end
  end
  
  describe ".svg_name" do
    it "should return 'in' for :inches" do
      expect(Units.svg_name(:inches)).to eq('in')
    end
    
    it "should return 'cm' for :centimeters" do
      expect(Units.svg_name(:centimeters)).to eq('cm')
    end
    
    it "should return 'mm' for :millimeters" do
      expect(Units.svg_name(:millimeters)).to eq('mm')
    end
    
    it "should return '' for :none" do
      expect(Units.svg_name(:none)).to eq('')
    end
    
    it "should raise an exception if called with an unknown unit" do
      expect {
        Units.svg_name(:error)
      }.to raise_error
    end
  end
  
  describe ".stroke_width" do
    it "should return 'in' for :inches" do
      expect(Units.stroke_width(:inches)).to eq(0.005)
    end
    
    it "should return 'cm' for :centimeters" do
      expect(Units.stroke_width(:centimeters)).to eq(0.01)
    end
    
    it "should return 'mm' for :millimeters" do
      expect(Units.stroke_width(:millimeters)).to eq(0.1)
    end
    
    it "should return '' for :none" do
      expect(Units.stroke_width(:none)).to eq(0.1)
    end
    
    it "should raise an exception if called with an unknown unit" do
      expect {
        Units.stroke_width(:error)
      }.to raise_error
    end
  end
end