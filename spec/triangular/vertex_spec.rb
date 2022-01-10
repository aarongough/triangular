# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Vertex do
  describe '.parse' do
    context 'with a correctly formatted vertex' do
      before do
        @result = Triangular::Vertex.parse("  vertex 16.5 0.0 -0.75\n")
      end

      it 'should return a vertex object' do
        expect(@result).to be_a Triangular::Vertex
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
  end

  describe '#to_s' do
    it "should return the keyword 'vertex' followed by the XYZ coordinates" do
      vertex = Triangular::Vertex.new(1.0, 2.0, -3.0)
      expect(vertex.to_s).to eq('vertex 1.0 2.0 -3.0')
    end
  end

  describe '#==' do
    it 'should return true when the vertices have identical values' do
      expect(Triangular::Vertex.new(1.0, 2.0, -3.1) == Triangular::Vertex.new(1.0, 2.0, -3.1)).to be true
    end

    it 'should return false when the vertices do not have identical values' do
      expect(Triangular::Vertex.new(1.0, 2.0, -3.1) == Triangular::Vertex.new(1.0, 2.0, -3.2)).to be false
    end
  end
end
