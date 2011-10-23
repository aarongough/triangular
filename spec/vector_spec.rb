require "spec_helper"

describe Vector do
  describe "#angle_to" do
    before do 
      @vector = Vector.new(0.0, 0.0, -1.0)
    end
    
    it "should return 180 for opposite vector" do
      @vector.angle_to(Vector.new(0.0, 0.0, 1.0))
    end
    
    it "should retun 90 for perpendicular vector" do
      @vector.angle_to(Vector.new(1.0, 0.0, 0.0))
    end
    
    it "should return 0 for same vector" do
      @vector.angle_to(Vector.new(0.0, 0.0, -1.0))
    end
  end
end