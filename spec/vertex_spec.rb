require 'spec_helper'

describe Vertex do
  describe ".parse" do
    context "with a correctly formatted vertex" do
      it "should return a vertex object" do
        vertex = Vertex.parse("vertex 16.5 0.0 -0.75")
        
        vertex.x.should = 16.5
        vertex.y.should = 0
        vertex.z.should = -0.75
      end
    end
  end
end