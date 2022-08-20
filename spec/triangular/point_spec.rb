# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Point do
  describe '.parse' do
    context 'with a correctly formatted point' do
      before do
        @result = Triangular::Point.parse('  16.5 0.0 -0.75 ')
      end

      it 'should return a point object' do
        expect(@result).to be_a Triangular::Point
      end

      it 'should correctly set the X value' do
        expect(@result.x).to eq(16.5)
      end

      it 'should correctly set the Y value' do
        expect(@result.y).to eq(0)
      end

      it 'should correctly set the Z value' do
        expect(@result.z).to eq(-0.75)
      end
    end

    context 'with a point that contains exponential notation' do
      before do
        @result = Triangular::Point.parse('  -5.23431439438796e-32 0.0 5.23431439438796e32 ')
      end

      it 'should correctly set the X value' do
        expect(@result.x).to eq(-5.23431439438796e-32)
      end

      it 'should correctly set the Y value' do
        expect(@result.y).to eq(0.0)
      end

      it 'should correctly set the Z value' do
        expect(@result.z).to eq(5.23431439438796e32)
      end
    end

    context 'with a point with no fractional part' do
      before do
        @result = Triangular::Point.parse('  -5 0 5 ')
      end

      it 'should correctly set the X value' do
        expect(@result.x).to eq(-5.0)
      end

      it 'should correctly set the Y value' do
        expect(@result.y).to eq(0.0)
      end

      it 'should correctly set the Z value' do
        expect(@result.z).to eq(5.0)
      end
    end
  end

  describe '#to_s' do
    it 'should return the XYZ components separated by spaces' do
      point = Triangular::Point.new(1.0, 2.0, -3.1)
      expect(point.to_s).to eq('1.0 2.0 -3.1')
    end

    it 'should convert integers into floats for output' do
      point = Triangular::Point.new(1, 2, 3)
      expect(point.to_s).to eq('1.0 2.0 3.0')
    end
  end

  describe '#==' do
    it 'should return true when the points have identical values' do
      expect(Triangular::Point.new(1.0, 2.0, -3.1) == Triangular::Point.new(1.0, 2.0, -3.1)).to be true
    end

    it 'should return false when the points do not have identical values' do
      expect(Triangular::Point.new(1.0, 2.0, -3.1) == Triangular::Point.new(1.0, 2.0, -3.2)).to be false
    end
  end

  describe '#translate!' do
    before do
      @point = Triangular::Point.new(1.0, 1.0, 1.0)
    end

    it 'should add the supplied value to X' do
      @point.translate!(16.5, 9.5, 0.75)
      expect(@point.x).to eq(17.5)
    end

    it 'should add the supplied value to Y' do
      @point.translate!(16.5, 9.5, 0.75)
      expect(@point.y).to eq(10.5)
    end

    it 'should add the supplied value to Z' do
      @point.translate!(16.5, 9.5, 0.75)
      expect(@point.z).to eq(1.75)
    end
  end
end
