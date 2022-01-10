# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Vector do
  describe '#angle_to' do
    before do
      @vector = Triangular::Vector.new(0.0, 0.0, -1.0)
    end

    it 'should return 180 for opposite vector' do
      @vector.angle_to(Triangular::Vector.new(0.0, 0.0, 1.0))
    end

    it 'should retun 90 for perpendicular vector' do
      @vector.angle_to(Triangular::Vector.new(1.0, 0.0, 0.0))
    end

    it 'should return 0 for same vector' do
      @vector.angle_to(Triangular::Vector.new(0.0, 0.0, -1.0))
    end
  end
end
