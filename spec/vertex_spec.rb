require 'spec_helper'

RSpec.describe Vertex do
  let(:instance) { Vertex.new(1.0, 2.0, -3.1) }

  describe ".parse" do
    subject { described_class.parse text }

    context "with a correctly formatted vertex" do
      let(:text) { "  vertex 16.5 0.0 -0.75\n" }
      
      it { should be_a Vertex }
      it { should eq Vertex.new(16.5, 0, -0.75) }
    end

    context "with a point that contains scientific notation" do
      let(:text) { "  vertex  0.000000E+00  0.800000E+01  0.000000E+00\n" }

      it { should eq Vertex.new(0.000000E+00, 0.800000E+01, 0.000000E+00) }
    end
  end
  
  describe "#to_s" do
    subject { instance.to_s }

    it { should eq "vertex 1.0 2.0 -3.1" }
  end
  
  describe "#==" do
    subject { instance == vertex }

    context "when vertext has the same values" do
      let(:vertex) { Vertex.new(1.0, 2.0, -3.1) }

      it { should eq true }
    end

    context "when vertext has different values" do
      let(:vertex) { Vertex.new(1.0, 2.0, -3.2) }

      it { should eq false }
    end
  end
end
