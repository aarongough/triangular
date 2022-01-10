# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Facet do
  describe '.parse' do
    context 'with a correctly formatted facet' do
      before :each do
        @result = Triangular::Facet.parse(<<-FACET)
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
        FACET
      end

      it 'should return a facet object' do
        expect(@result).to be_a Triangular::Facet
      end

      it 'should return a facet with 3 vertices' do
        expect(@result.vertices.length).to eq(3)
      end

      it 'should return a facet with vertices of type Vertex' do
        @result.vertices.each do |vertex|
          expect(vertex).to be_a Triangular::Vertex
        end
      end

      it 'should return a facet with a normal of type Vector' do
        expect(@result.normal).to be_a Triangular::Vector
      end

      it 'should correctly set the normal values' do
        expect(@result.normal.x).to eq(0)
        expect(@result.normal.y).to eq(0)
        expect(@result.normal.z).to eq(-1)
      end

      it 'should correctly set the values for the first vertex' do
        expect(@result.vertices[0].x).to eq(16.5)
        expect(@result.vertices[0].y).to eq(0)
        expect(@result.vertices[0].z).to eq(-0.75)
      end

      it 'should correctly set the values for the second vertex' do
        expect(@result.vertices[1].x).to eq(0)
        expect(@result.vertices[1].y).to eq(-9.5)
        expect(@result.vertices[1].z).to eq(-0.75)
      end

      it 'should correctly set the values for the third vertex' do
        expect(@result.vertices[2].x).to eq(0)
        expect(@result.vertices[2].y).to eq(0)
        expect(@result.vertices[2].z).to eq(-0.75)
      end
    end

    context 'when passed multiple facets' do
      before do
        @result = Triangular::Facet.parse(<<-FACET)
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
        FACET
      end

      it 'should return multiple facet objects' do
        expect(@result).to be_a Array
        @result.each do |item|
          expect(item).to be_a Triangular::Facet
        end
      end
    end
  end

  describe '#to_s' do
    it 'should return the string representation for a facet' do
      facet = Triangular::Facet.new
      facet.normal = Triangular::Vector.new(0, 0, 1)
      facet.vertices << Triangular::Point.new(1, 2, 3)
      facet.vertices << Triangular::Point.new(1, 2, 3)
      facet.vertices << Triangular::Point.new(1, 2, 3)

      expected_string  = "facet normal 0.0 0.0 1.0\n"
      expected_string += "outer loop\n"
      expected_string += "#{facet.vertices[0]}\n"
      expected_string += "#{facet.vertices[1]}\n"
      expected_string += "#{facet.vertices[2]}\n"
      expected_string += "endloop\n"
      expected_string += "endfacet\n"

      expect(facet.to_s).to eq(expected_string)
    end
  end

  describe '#intersection_at_z' do
    context 'for a facet that intersects the target Z plane' do
      before do
        vertex1 = Triangular::Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Triangular::Vertex.new(0.0, 0.0, 6.0)
        vertex3 = Triangular::Vertex.new(6.0, 0.0, 6.0)

        @facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)
      end

      context 'when the target Z plane is 3.0' do
        it 'should return a line object' do
          expect(@facet.intersection_at_z(3.0)).to be_a Triangular::Line
        end

        it 'should return a line with the correct start value' do
          expect(@facet.intersection_at_z(3.0).start.x).to eq(0.0)
          expect(@facet.intersection_at_z(3.0).start.y).to eq(0.0)
          expect(@facet.intersection_at_z(3.0).start.z).to eq(3.0)
        end

        it 'should return a line with the correct end value' do
          expect(@facet.intersection_at_z(3.0).end.x).to eq(3.0)
          expect(@facet.intersection_at_z(3.0).end.y).to eq(0.0)
          expect(@facet.intersection_at_z(3.0).end.z).to eq(3.0)
        end
      end

      context 'when the target Z plane is 6.0' do
        it 'should return a line object' do
          expect(@facet.intersection_at_z(6.0)).to be_a Triangular::Line
        end

        it 'should return a line with the correct start value' do
          expect(@facet.intersection_at_z(6.0).start.x).to eq(0.0)
          expect(@facet.intersection_at_z(6.0).start.y).to eq(0.0)
          expect(@facet.intersection_at_z(6.0).start.z).to eq(6.0)
        end

        it 'should return a line with the correct end value' do
          expect(@facet.intersection_at_z(6.0).end.x).to eq(6.0)
          expect(@facet.intersection_at_z(6.0).end.y).to eq(0.0)
          expect(@facet.intersection_at_z(6.0).end.z).to eq(6.0)
        end
      end
    end

    context 'with vertices in both positive and negative space' do
      before do
        @facet = Triangular::Facet.parse(<<-FACET)
          facet normal -0.0 1.0 -0.0
          outer loop
          vertex -1.0 1.0 1.0
          vertex 1.0 1.0 -1.0
          vertex -1.0 1.0 -1.0
          endloop
          endfacet
        FACET
      end

      it 'should return a line with the correct start value' do
        expect(@facet.intersection_at_z(0.0).start.x).to eq(0.0)
        expect(@facet.intersection_at_z(0.0).start.y).to eq(1.0)
        expect(@facet.intersection_at_z(0.0).start.z).to eq(0.0)
      end

      it 'should return a line with the correct end value' do
        expect(@facet.intersection_at_z(0.0).end.x).to eq(-1.0)
        expect(@facet.intersection_at_z(0.0).end.y).to eq(1.0)
        expect(@facet.intersection_at_z(0.0).end.z).to eq(0.0)
      end
    end

    context 'for a facet that lies on the target Z plane' do
      before do
        vertex1 = Triangular::Vertex.new(0.0, 0.0, 1.0)
        vertex2 = Triangular::Vertex.new(2.0, 0.0, 1.0)
        vertex3 = Triangular::Vertex.new(2.0, 2.0, 1.0)

        @facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)
      end

      it 'should return nil' do
        expect(@facet.intersection_at_z(1.0)).to eq(nil)
      end
    end

    context 'for a facet that does not intersect the target Z plane' do
      before do
        vertex1 = Triangular::Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Triangular::Vertex.new(2.0, 0.0, 0.0)
        vertex3 = Triangular::Vertex.new(2.0, 2.0, 0.0)

        @facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)
      end

      it 'should return nil' do
        expect(@facet.intersection_at_z(1.0)).to eq(nil)
      end
    end
  end

  describe '#translate!' do
    before do
      @facet = Triangular::Facet.parse(<<-FACET)
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 -0.75
        vertex 0.0 -9.5 -0.75
        vertex 0.0 0.0 -0.75
        endloop
        endfacet
      FACET
    end

    it "should call translate on each of it's Vertices" do
      expect(@facet.vertices[0]).to receive(:translate!).with(16.5, 9.5, 0.75)
      expect(@facet.vertices[1]).to receive(:translate!).with(16.5, 9.5, 0.75)
      expect(@facet.vertices[2]).to receive(:translate!).with(16.5, 9.5, 0.75)

      @facet.translate!(16.5, 9.5, 0.75)
    end
  end
end
