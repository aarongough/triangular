require 'spec_helper'

describe Ray do
  describe '#intersection' do
    before do
      @ray = Ray.new(1.0, 1.0)
    end

    context 'with facet that does not intersect the Ray' do
      it 'should return nil' do
        vertex1 = Vertex.new(1.1, 1.1, 1.0)
        vertex2 = Vertex.new(2.0, 1.1, 1.0)
        vertex3 = Vertex.new(2.0, 2.0, 1.0)

        facet = Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(nil)
      end
    end

    context 'with flat facet that intersects the Ray' do
      it 'should return Point that represents intersection' do
        vertex1 = Vertex.new(0.0, 0.0, 1.2)
        vertex2 = Vertex.new(2.0, 0.0, 1.2)
        vertex3 = Vertex.new(2.0, 2.0, 1.2)

        facet = Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(Point.new(1.0, 1.0, 1.2))
      end
    end

    context 'with simple angled facet that intersects the Ray' do
      it 'should return Point that represents intersection' do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(2.0, 0.0, 2.0)
        vertex3 = Vertex.new(2.0, 2.0, 2.0)

        facet = Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(Point.new(1.0, 1.0, 1.0))
      end
    end

    context 'with compound angled facet that intersects the Ray' do
      before do
        @ray = Ray.new(0.5, 0.5)
      end

      it 'should return Point that represents intersection' do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(2.0, 0.0, 1.0)
        vertex3 = Vertex.new(0.0, 2.0, 2.0)

        facet = Facet.new(nil, vertex1, vertex2, vertex3)

        expect(@ray.intersection(facet)).to eq(Point.new(0.5, 0.5, 0.75))
      end
    end
  end
end
