require "spec_helper"

describe Ray do
  describe "#intersection" do
    subject { instance.intersection facet }

    let(:instance) { Ray.new(1.0, 1.0) }

    context "with facet that does not intersect the Ray" do
      let(:facet) do
        vertex1 = Vertex.new(1.1, 1.1, 1.0)
        vertex2 = Vertex.new(2.0, 1.1, 1.0)
        vertex3 = Vertex.new(2.0, 2.0, 1.0)

        Facet.new(nil, vertex1, vertex2, vertex3)
      end

      it { should be_nil }
    end

    context "with flat facet that intersects the Ray" do
      let(:facet) do
        vertex1 = Vertex.new(0.0, 0.0, 1.2)
        vertex2 = Vertex.new(2.0, 0.0, 1.2)
        vertex3 = Vertex.new(2.0, 2.0, 1.2)

        Facet.new(nil, vertex1, vertex2, vertex3)
      end

      it "should return Point that represents intersection" do
        should eq Point.new(1.0, 1.0, 1.2)
      end
    end

    context "with simple angled facet that intersects the Ray" do
      let(:facet) do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(2.0, 0.0, 2.0)
        vertex3 = Vertex.new(2.0, 2.0, 2.0)

        Facet.new(nil, vertex1, vertex2, vertex3)
      end

      it "should return Point that represents intersection" do
        should eq Point.new(1.0, 1.0, 1.0)
      end
    end

    context "with compound angled facet that intersects the Ray" do
      let(:instance) { Ray.new(0.5, 0.5) }

      let(:facet) do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(2.0, 0.0, 1.0)
        vertex3 = Vertex.new(0.0, 2.0, 2.0)

        Facet.new(nil, vertex1, vertex2, vertex3)
      end

      it "should return Point that represents intersection" do
        should eq Point.new(0.5, 0.5, 0.75)
      end
    end
  end
end
