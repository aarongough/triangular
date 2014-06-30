require 'spec_helper'

RSpec.describe Facet do
  describe ".parse" do
    subject { described_class.parse text }

    context "with a correctly formatted facet" do
      let(:text) do
        <<-EOD
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
        EOD
      end
      
      it "should return a facet object" do
        should be_a Facet
      end
      
      specify "should return a facet with 3 vertices" do
        expect(subject.vertices.length).to eq 3
      end
      
      specify "should return a facet with vertices of type Vertex" do
        subject.vertices.each do |vertex|
          expect(vertex).to be_a Vertex
        end
      end
      
      specify "should return a facet with a normal of type Vector" do
        expect(subject.normal).to be_a Vector
      end
      
      specify "should correctly set the normal values" do
        expect(subject.normal.x).to eq 0
        expect(subject.normal.y).to eq 0
        expect(subject.normal.z).to eq -1
      end
      
      specify "should correctly set the values for the first vertex" do
        expect(subject.vertices[0].x).to eq 16.5
        expect(subject.vertices[0].y).to eq 0
        expect(subject.vertices[0].z).to eq -0.75
      end
      
      specify "should correctly set the values for the second vertex" do
        expect(subject.vertices[1].x).to eq 0
        expect(subject.vertices[1].y).to eq -9.5
        expect(subject.vertices[1].z).to eq -0.75
      end
      
      specify "should correctly set the values for the third vertex" do
        expect(subject.vertices[2].x).to eq 0
        expect(subject.vertices[2].y).to eq 0
        expect(subject.vertices[2].z).to eq -0.75
      end
    end
    
    context "when passed multiple facets" do
      let(:text) do
        <<-EOD
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
        EOD
      end

      specify "should return multiple facet objects" do
        expect(subject).to be_a Array
        subject.each do |item|
          expect(item).to be_a Facet
        end
      end
    end
  end
  
  describe "#to_s" do
    subject { instance.to_s }

    let(:instance) do
      facet = Facet.new
      facet.normal = Vector.new(0, 0, 1)
      facet.vertices << Point.new(1, 2, 3)
      facet.vertices << Point.new(1, 2, 3)
      facet.vertices << Point.new(1, 2, 3)
      facet
    end

    let(:expected_string) do
      expected_string  = "facet normal 0.0 0.0 1.0\n"
      expected_string += "outer loop\n"
      expected_string += instance.vertices[0].to_s + "\n"
      expected_string += instance.vertices[1].to_s + "\n"
      expected_string += instance.vertices[2].to_s + "\n"
      expected_string += "endloop\n"
      expected_string += "endfacet\n"
      expected_string
    end

    it { should eq expected_string }
  end
  
  describe "#intersection_at_z" do
    subject { instance.intersection_at_z value }

    context "for a facet that intersects the target Z plane" do
      let(:instance) do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(0.0, 0.0, 6.0)
        vertex3 = Vertex.new(6.0, 0.0, 6.0)

        Facet.new(nil, vertex1, vertex2, vertex3)
      end

      context "when the target Z plane is 3.0" do
        let(:value) { 3.0 }

        it { should be_a Line }

        specify "should return a line wspecifyh the correct start value" do
          expect(subject.start.x).to eq 0.0
          expect(subject.start.y).to eq 0.0
          expect(subject.start.z).to eq 3.0
        end

        specify "should return a line wspecifyh the correct end value" do
          expect(subject.end.x).to eq 3.0
          expect(subject.end.y).to eq 0.0
          expect(subject.end.z).to eq 3.0
        end
      end

      context "when the target Z plane is 6.0" do
        let(:value) { 6.0 }

        it { should be_a Line }

        specify "should return a line wspecifyh the correct start value" do
          expect(subject.start.x).to eq 0.0
          expect(subject.start.y).to eq 0.0
          expect(subject.start.z).to eq 6.0
        end

        specify "should return a line wspecifyh the correct end value" do
          expect(subject.end.x).to eq 6.0
          expect(subject.end.y).to eq 0.0
          expect(subject.end.z).to eq 6.0
        end
      end
    end
    
    context "with vertices in both positive and negative space" do
      let(:instance) do
        Facet.parse(<<-EOD)
          facet normal -0.0 1.0 -0.0
          outer loop
          vertex -1.0 1.0 1.0
          vertex 1.0 1.0 -1.0
          vertex -1.0 1.0 -1.0
          endloop
          endfacet
        EOD
      end

      let(:value) { 0.0 }

      specify "should return a line wspecifyh the correct start value" do
        expect(subject.start.x).to eq 0.0
        expect(subject.start.y).to eq 1.0
        expect(subject.start.z).to eq 0.0
      end

      specify "should return a line wspecifyh the correct end value" do
        expect(subject.end.x).to eq -1.0
        expect(subject.end.y).to eq 1.0
        expect(subject.end.z).to eq 0.0
      end
    end
    
    context "for a facet that lies on the target Z plane" do
      let(:instance) do
        vertex1 = Vertex.new(0.0, 0.0, 1.0)
        vertex2 = Vertex.new(2.0, 0.0, 1.0)
        vertex3 = Vertex.new(2.0, 2.0, 1.0)
        
        Facet.new(nil, vertex1, vertex2, vertex3)
      end

      let(:value) { 1.0 }

      it { should be_nil }
    end

    context "for a facet that does not intersect the target Z plane" do
      let(:instance) do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(2.0, 0.0, 0.0)
        vertex3 = Vertex.new(2.0, 2.0, 0.0)

        Facet.new(nil, vertex1, vertex2, vertex3)
      end
      
      let(:value) { 1.0 }

      it { should be_nil }
    end
  end
  
  describe "#translate!" do
    let(:instance) do
      Facet.parse(<<-EOD)
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 -0.75
        vertex 0.0 -9.5 -0.75
        vertex 0.0 0.0 -0.75
        endloop
        endfacet
      EOD
    end
    
    specify "should call translate on each of it's Vertices" do
      expect(instance.vertices[0]).to receive(:translate!).with(16.5, 9.5, 0.75)
      expect(instance.vertices[1]).to receive(:translate!).with(16.5, 9.5, 0.75)
      expect(instance.vertices[2]).to receive(:translate!).with(16.5, 9.5, 0.75)
      
      instance.translate!(16.5, 9.5, 0.75)
    end
  end
end
