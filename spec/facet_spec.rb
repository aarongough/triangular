require 'spec_helper'

describe Facet do
  describe ".parse" do
    context "with a correctly formatted facet" do
      before do
        @result = Facet.parse(<<-EOD)
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
        EOD
      end
      
      it "should return a facet object" do
        @result.should be_a Facet
      end
      
      it "should return a facet with 3 vertices" do
        @result.vertices.length.should == 3
      end
      
      it "should return a facet with vertices of type Vertex" do
        @result.vertices.each do |vertex|
          vertex.should be_a Vertex
        end
      end
      
      it "should return a facet with a normal of type Vector" do
        @result.normal.should be_a Vector
      end
      
      it "should correctly set the normal values" do
        @result.normal.x.should == 0
        @result.normal.y.should == 0
        @result.normal.z.should == -1
      end
      
      it "should correctly set the values for the first vertex" do
        @result.vertices[0].x.should == 16.5
        @result.vertices[0].y.should == 0
        @result.vertices[0].z.should == -0.75
      end
      
      it "should correctly set the values for the second vertex" do
        @result.vertices[1].x.should == 0
        @result.vertices[1].y.should == -9.5
        @result.vertices[1].z.should == -0.75
      end
      
      it "should correctly set the values for the third vertex" do
        @result.vertices[2].x.should == 0
        @result.vertices[2].y.should == 0
        @result.vertices[2].z.should == -0.75
      end
    end
    
    context "when passed multiple facets" do
      before do
        @result = Facet.parse(<<-EOD)
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
        EOD
      end
      
      it "should return multiple facet objects" do
        @result.should be_a Array
        @result.each do |item|
          item.should be_a Facet
        end
      end
    end
  end
  
  describe "#to_s" do
    it "should return the string representation for a facet" do
      facet = Facet.new
      facet.normal = Vector.new(0, 0, 1)
      facet.vertices << Point.new(1, 2, 3)
      facet.vertices << Point.new(1, 2, 3)
      facet.vertices << Point.new(1, 2, 3)
      
      expected_string  = "facet normal 0.0 0.0 1.0\n"
      expected_string += "outer loop\n"
      expected_string += facet.vertices[0].to_s + "\n"
      expected_string += facet.vertices[1].to_s + "\n"
      expected_string += facet.vertices[2].to_s + "\n"
      expected_string += "endloop\n"
      expected_string += "endfacet\n"
      
      facet.to_s.should == expected_string
    end
  end
  
  describe "#intersection_at_z" do
    context "for a facet that intersects the target Z plane" do
      before do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(0.0, 0.0, 6.0)
        vertex3 = Vertex.new(6.0, 0.0, 6.0)
        
        @facet = Facet.new(nil, vertex1, vertex2, vertex3)
      end
      
      context "when the target Z plane is 3.0" do
        it "should return a line object" do
          @facet.intersection_at_z(3.0).should be_a Line
        end
        
        it "should return a line with the correct start value" do
          @facet.intersection_at_z(3.0).start.x.should == 0.0
          @facet.intersection_at_z(3.0).start.y.should == 0.0
          @facet.intersection_at_z(3.0).start.z.should == 3.0
        end
        
        it "should return a line with the correct end value" do
          @facet.intersection_at_z(3.0).end.x.should == 3.0
          @facet.intersection_at_z(3.0).end.y.should == 0.0
          @facet.intersection_at_z(3.0).end.z.should == 3.0
        end
      end
      
      context "when the target Z plane is 6.0" do
        it "should return a line object" do
          @facet.intersection_at_z(6.0).should be_a Line
        end
        
        it "should return a line with the correct start value" do
          @facet.intersection_at_z(6.0).start.x.should == 0.0
          @facet.intersection_at_z(6.0).start.y.should == 0.0
          @facet.intersection_at_z(6.0).start.z.should == 6.0
        end
        
        it "should return a line with the correct end value" do
          @facet.intersection_at_z(6.0).end.x.should == 6.0
          @facet.intersection_at_z(6.0).end.y.should == 0.0
          @facet.intersection_at_z(6.0).end.z.should == 6.0
        end
      end
    end
    
    context "for a facet that intersects the target Z plane at an angle" do
      before do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(0.0, 6.0, 6.0)
        vertex3 = Vertex.new(6.0, 6.0, 6.0)
        
        @facet = Facet.new(nil, vertex1, vertex2, vertex3)
      end
      
      context "when the target Z plane is 3.0" do
        it "should return a line object" do
          @facet.intersection_at_z(3.0).should be_a Line
        end
        
        it "should return a line with the correct start value" do
          @facet.intersection_at_z(3.0).start.x.should == 0.0
          @facet.intersection_at_z(3.0).start.y.should == 3.0
          @facet.intersection_at_z(3.0).start.z.should == 3.0
        end
        
        it "should return a line with the correct end value" do
          @facet.intersection_at_z(3.0).end.x.should == 3.0
          @facet.intersection_at_z(3.0).end.y.should == 3.0
          @facet.intersection_at_z(3.0).end.z.should == 3.0
        end
      end
      
      context "when the target Z plane is 6.0" do
        it "should return a line object" do
          @facet.intersection_at_z(6.0).should be_a Line
        end
        
        it "should return a line with the correct start value" do
          @facet.intersection_at_z(6.0).start.x.should == 0.0
          @facet.intersection_at_z(6.0).start.y.should == 6.0
          @facet.intersection_at_z(6.0).start.z.should == 6.0
        end
        
        it "should return a line with the correct end value" do
          @facet.intersection_at_z(6.0).end.x.should == 6.0
          @facet.intersection_at_z(6.0).end.y.should == 6.0
          @facet.intersection_at_z(6.0).end.z.should == 6.0
        end
      end
    end
    
    context "for a facet that lies on the target Z plane" do
      before do
        vertex1 = Vertex.new(0.0, 0.0, 1.0)
        vertex2 = Vertex.new(2.0, 0.0, 1.0)
        vertex3 = Vertex.new(2.0, 2.0, 1.0)
        
        @facet = Facet.new(nil, vertex1, vertex2, vertex3)
      end
      
      it "should return nil" do
        @facet.intersection_at_z(1.0).should == nil
      end
    end
    
    context "for a facet that does not intersect the target Z plane" do
      before do
        vertex1 = Vertex.new(0.0, 0.0, 0.0)
        vertex2 = Vertex.new(2.0, 0.0, 0.0)
        vertex3 = Vertex.new(2.0, 2.0, 0.0)
        
        @facet = Facet.new(nil, vertex1, vertex2, vertex3)
      end
      
      it "should return nil" do
        @facet.intersection_at_z(1.0).should == nil
      end
    end
  end
end