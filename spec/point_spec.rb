require 'spec_helper'

RSpec.describe Point do
  let(:instance) { Point.new(1.0, 2.0, -3.1) }

  describe ".parse" do
    subject { described_class.parse text }

    context "with a correctly formatted point" do
      let(:text) { "  16.5 0.0 -0.75 " }

      it { should be_a Point }
      it { should eq Point.new(16.5, 0.0, -0.75) }
    end
    
    context "with a point that contains exponential notation" do
      let(:text) { "  -5.23431439438796e-32 0.0 5.23431439438796e32 " }

      it { should be_a Point }
      it { should eq Point.new(-5.23431439438796e-32, 0.0, 5.23431439438796e32) }
    end
  end
  
  describe "#to_s" do
    subject { instance.to_s }

    it { should eq "1.0 2.0 -3.1" }
    
    context "when it is initiated with integers" do
      let(:instance) { Point.new(1, 2, 3) }

      it { should eq "1.0 2.0 3.0" }
    end
  end
  
  describe "#==" do
    subject { instance == point }

    context "when the point has identical values" do
      let(:point) { Point.new(1.0, 2.0, -3.1) }

      it { should eq true }
    end
    
    context "when the point has different values" do
      let(:point) { Point.new(1.0, 2.0, -3.2) }

      it { should eq false }
    end
  end
  
  context "after #translate!" do
    subject { Point.new(1.0, 1.0, 1.0) }

    before { subject.translate!(16.5, 9.5, 0.75) }

    it { should eq Point.new(17.5, 10.5, 1.75) }
  end
end
