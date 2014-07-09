require 'spec_helper'

RSpec.describe Units do
  describe ".name" do
    subject { described_class.name input }

    context "when input :inches" do
      let(:input) { :inches }
      it { should eq 'inches' }
    end

    context "when input :centimeters" do
      let(:input) { :centimeters }
      it { should eq 'centimeters' }
    end

    context "when input :millimeters" do
      let(:input) { :millimeters }
      it { should eq 'millimeters' }
    end

    context "when input :none" do
      let(:input) { :none }
      it { should eq 'none' }
    end

    context "if called with an unknown unit" do
      let(:input) { :error }
      specify { expect { subject }.to raise_error }
    end
  end
  
  describe ".svg_name" do
    subject { described_class.svg_name input }

    context "when input :inches" do
      let(:input) { :inches }
      it { should eq 'in' }
    end

    context "when input :centimeters" do
      let(:input) { :centimeters }
      it { should eq 'cm' }
    end

    context "when input :millimeters" do
      let(:input) { :millimeters }
      it { should eq 'mm' }
    end

    context "when input :none" do
      let(:input) { :none }
      it { should eq '' }
    end
    
    context "if called with an unknown unit" do
      let(:input) { :error }
      specify { expect { subject }.to raise_error }
    end
  end
  
  describe ".stroke_width" do
    subject { described_class.stroke_width input }

    context "when input :inches" do
      let(:input) { :inches }
      it { should eq 0.005 }
    end

    context "when input :centimeters" do
      let(:input) { :centimeters }
      it { should eq 0.01 }
    end

    context "when input :millimeters" do
      let(:input) { :millimeters }
      it { should eq 0.1 }
    end

    context "when input :none" do
      let(:input) { :none }
      it { should eq 0.1 }
    end

    context "if called with an unknown unit" do
      let(:input) { :error }
      specify { expect { subject }.to raise_error }
    end
  end
end
