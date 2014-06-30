require 'spec_helper'

RSpec.describe Solid do
  describe ".parse" do
    subject { described_class.parse text }

    context "with a correctly formatted solid" do
      let(:text) do
        <<-EOD
          solid y-axis-spacer
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
          facet normal -0.0 1.0 0.0
          outer loop
          vertex 0.0 -1.87 0.0
          vertex 16.5 -1.87 -0.13
          vertex 0.0 -1.87 -0.13
          endloop
          endfacet
          endsolid y-axis-spacer
          
        EOD
      end

      it "should return a Solid" do
        should be_a Solid
      end

      specify "should correctly set the name parameter" do
        expect(subject.name).to eq "y-axis-spacer"
      end

      specify "should retun a Solid that has two Facets" do
        expect(subject.facets.length).to eq 2
      end
      
      specify "should return a Solid that has facets of type Facet" do
        subject.facets.each do |facet|
          expect(facet).to be_a Facet
        end
      end
    end
  end
  
  describe "#to_s" do
    subject { instance.to_s }

    let(:instance) do
      described_class.parse input
    end

    let(:input) do
      input  = "solid y-axis-spacer\n"
      input += "facet normal 0.0 0.0 -1.0\n"
      input += "outer loop\n"
      input += "vertex 16.5 0.0 -0.75\n"
      input += "vertex 0.0 -9.5 -0.75\n"
      input += "vertex 0.0 0.0 -0.75\n"
      input += "endloop\n"
      input += "endfacet\n"
      input += "facet normal -0.0 1.0 0.0\n"
      input += "outer loop\n"
      input += "vertex 0.0 -1.87 0.0\n"
      input += "vertex 16.5 -1.87 -0.13\n"
      input += "vertex 0.0 -1.87 -0.13\n"
      input += "endloop\n"
      input += "endfacet\n"
      input += "endsolid y-axis-spacer\n"
      input
    end

    it "should output a string representation exactly the same as the input" do
      should eq input
    end
  end

  describe "#slice_at_z" do
    subject { instance.slice_at_z 0 }
    let(:instance) { Solid.parse(File.open("#{File.dirname(__FILE__)}/fixtures/test_cube.stl").read) }

    it "should return a Polyline" do
      should be_a Polyline
    end
  end
  
  describe "#get_bounds" do
    subject { instance.get_bounds }

    let(:instance) do
      Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 -0.75
        vertex 0.0 -9.5 -0.75
        vertex 0.0 0.0 -0.75
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 0.0
        vertex 16.5 -1.87 -0.13
        vertex 0.0 1.87 -0.13
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    it "should return an array" do
      should be_a Array
    end

    specify "should return a point wspecifyh the smallest bounds" do
      expect(subject[0].x).to eq -16.5
      expect(subject[0].y).to eq -9.5
      expect(subject[0].z).to eq -0.75
    end

    specify "should return a point wspecifyh the largest bounds" do
      expect(subject[1].x).to eq 16.5
      expect(subject[1].y).to eq 1.87
      expect(subject[1].z).to eq 0.0
    end
  end

  describe "#translate!" do
    let(:instance) do
      Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 -0.75
        vertex 0.0 -9.5 -0.75
        vertex 0.0 0.0 -0.75
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 0.0
        vertex 16.5 -1.87 -0.13
        vertex 0.0 1.87 -0.13
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    specify "should call translate on each of it's Facets" do
      expect(instance.facets[0]).to receive(:translate!).with(16.5, 9.5, 0.75)
      expect(instance.facets[1]).to receive(:translate!).with(16.5, 9.5, 0.75)

      instance.translate!(16.5, 9.5, 0.75)
    end
  end
  
  describe "#align_to_origin!" do
    let(:instance) do
      Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 5.0
        vertex 0.0 -9.5 10.0
        vertex 0.0 0.0 5.0
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 5.0
        vertex 16.5 -1.87 11.0
        vertex 0.0 1.87 6.0
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end

    specify "should translate solid so the lowermost XYZ edges are all 0.0" do
      expect(instance).to receive(:translate!).with(16.5, 9.5, -5.0)
      instance.align_to_origin!
    end
  end
  
  describe "#center!" do
    let(:instance) do
      Solid.parse(<<-EOD)
        solid y-axis-spacer
        facet normal 0.0 0.0 -1.0
        outer loop
        vertex -16.5 0.0 5.0
        vertex 0.0 -9.5 10.0
        vertex 0.0 0.0 5.0
        endloop
        endfacet
        facet normal -0.0 1.0 0.0
        outer loop
        vertex 0.0 -1.87 5.0
        vertex 17.5 -1.87 11.0
        vertex 0.0 1.5 6.0
        endloop
        endfacet
        endsolid y-axis-spacer
      EOD
    end
    
    specify "should translate solid so the lowermost XYZ edges are all 0.0" do
      expect(instance).to receive(:translate!).with(-0.5, 4.0, -8.0)
      instance.center!
    end
  end
end
