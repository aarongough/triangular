# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Units do
  describe '.name' do
    it "should return 'inches' for :inches" do
      expect(Triangular::Units.name(:inches)).to eq('inches')
    end

    it "should return 'centimeters' for :centimeters" do
      expect(Triangular::Units.name(:centimeters)).to eq('centimeters')
    end

    it "should return 'millimeters' for :millimeters" do
      expect(Triangular::Units.name(:millimeters)).to eq('millimeters')
    end

    it "should return 'none' for :none" do
      expect(Triangular::Units.name(:none)).to eq('none')
    end

    it 'should raise an exception if called with an unknown unit' do
      expect do
        Triangular::Units.name(:error)
      end.to raise_error(Triangular::UnknownUnitError)
    end
  end

  describe '.svg_name' do
    it "should return 'in' for :inches" do
      expect(Triangular::Units.svg_name(:inches)).to eq('in')
    end

    it "should return 'cm' for :centimeters" do
      expect(Triangular::Units.svg_name(:centimeters)).to eq('cm')
    end

    it "should return 'mm' for :millimeters" do
      expect(Triangular::Units.svg_name(:millimeters)).to eq('mm')
    end

    it "should return '' for :none" do
      expect(Triangular::Units.svg_name(:none)).to eq('')
    end

    it 'should raise an exception if called with an unknown unit' do
      expect do
        Triangular::Units.svg_name(:error)
      end.to raise_error(Triangular::UnknownUnitError)
    end
  end

  describe '.stroke_width' do
    it "should return 'in' for :inches" do
      expect(Triangular::Units.stroke_width(:inches)).to eq(0.005)
    end

    it "should return 'cm' for :centimeters" do
      expect(Triangular::Units.stroke_width(:centimeters)).to eq(0.01)
    end

    it "should return 'mm' for :millimeters" do
      expect(Triangular::Units.stroke_width(:millimeters)).to eq(0.1)
    end

    it "should return '' for :none" do
      expect(Triangular::Units.stroke_width(:none)).to eq(0.1)
    end

    it 'should raise an exception if called with an unknown unit' do
      expect do
        Triangular::Units.stroke_width(:error)
      end.to raise_error(Triangular::UnknownUnitError)
    end
  end
end
