# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Ray do
  describe '#intersection' do
    before do
      @ray = Triangular::Ray.new(1.0, 1.0)
    end

    context 'with facet that does not intersect the Ray' do
      it 'should return nil' do
        vertex1 = Triangular::Vertex.new(1.1, 1.1, 1.0)
        vertex2 = Triangular::Vertex.new(2.0, 1.1, 1.0)
        vertex3 = Triangular::Vertex.new(2.0, 2.0, 1.0)

        facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(nil)
      end
    end

    context 'with flat facet that intersects the Ray' do
      it 'should return Point that represents intersection' do
        vertex1 = Triangular::Vertex.new(0.0, 0.0, 1.2)
        vertex2 = Triangular::Vertex.new(2.0, 0.0, 1.2)
        vertex3 = Triangular::Vertex.new(2.0, 2.0, 1.2)

        facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(Triangular::Point.new(1.0, 1.0, 1.2))
      end
    end

    context 'with simple angled facet that intersects the Ray' do
      it 'should return Point that represents intersection' do
        vertex1 = Triangular::Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Triangular::Vertex.new(2.0, 0.0, 2.0)
        vertex3 = Triangular::Vertex.new(2.0, 2.0, 2.0)

        facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(Triangular::Point.new(1.0, 1.0, 1.0))
      end
    end

    context 'with compound angled facet that intersects the Ray' do
      before do
        @ray = Triangular::Ray.new(0.5, 0.5)
      end

      it 'should return Point that represents intersection' do
        vertex1 = Triangular::Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Triangular::Vertex.new(2.0, 0.0, 1.0)
        vertex3 = Triangular::Vertex.new(0.0, 2.0, 2.0)

        facet = Triangular::Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(Triangular::Point.new(0.5, 0.5, 0.75))
      end
    end
  end
end
