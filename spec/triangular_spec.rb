require 'spec_helper'

RSpec.describe Triangular do  
  describe ".parse" do
    subject { described_class.parse input }

    let(:input) { File.open("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl").read }

    it "should return a Solid" do
      should be_a Solid
    end
  end

  describe ".parse_file" do
    subject { described_class.parse_file file }

    let(:file) { File.open(File.expand_path("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl")) }

    it "should return a Solid" do
      should be_a Solid
    end

    specify 'should has the right content' do
      expect(subject.to_s).to eq file.read
    end

    context "when file is in binary" do
      let(:file) { File.open(File.expand_path("#{File.dirname(__FILE__)}/fixtures/test_binary_cube.stl")) }
      it { should be_a Solid }

      specify "should have 12 facets" do
        expect(subject.facets.length).to eq 12
      end
    end

    context "when file is faked ascii" do
      let(:file) { File.open(File.expand_path("#{File.dirname(__FILE__)}/fixtures/fake_ascii.stl")) }

      specify "should call Solid#parse_binary" do
        expect(Solid).to receive(:parse_binary).with(file.read)
        subject
      end

      specify "should have 12 facets" do
        expect(subject.facets.length).to eq 12
      end
    end
  end
end
