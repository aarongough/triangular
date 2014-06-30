require "spec_helper"

RSpec.describe Vector do
  describe "#angle_to" do
    subject { instance.angle_to vector }

    let(:instance) { Vector.new(0.0, 0.0, -1.0) }

    context "for opposite vector" do
      let(:vector) { Vector.new(0.0, 0.0, 1.0) }
      it { should eq 180 }
    end

    context "for perpendicular vector" do
      let(:vector) { Vector.new(1.0, 0.0, 0.0) }
      it { should eq 90 }
    end

    context "for same vector" do
      let(:vector) { Vector.new(0.0, 0.0, -1.0) }
      it { should eq 0 }
    end
  end
end
