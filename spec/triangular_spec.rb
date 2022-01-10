require 'spec_helper'

describe Triangular do
  describe '.parse' do
    it 'should return a Solid' do
      stl_string = File.open("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl").read
      result = Triangular.parse(stl_string)

      expect(result).to be_a Solid
    end
  end

  describe '.parse_file' do
    it 'should return a Solid' do
      input = File.open(File.expand_path("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl")).read
      result = Triangular.parse_file(File.expand_path("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl"))
      expect(result).to be_a Solid

      expect(result.to_s).to eq(input)
    end
  end
end
