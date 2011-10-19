require 'spec_helper'

describe Line do
  describe "#intersects_z?" do 
    context "for a line that intersects the target Z plane" do
      context "with a positive Z vector" do
        before do
          @line = Line.new(Vertex.new(0.0, 0.0, 0.0), Vertex.new(0.0, 0.0, 6.0))
        end
        
        it "should return true" do
          @line.intersects_z?(3.0).should be_true
        end
      end
      
      context "with a negative Z vector" do
        before do
          @line = Line.new(Vertex.new(0.0, 0.0, 6.0), Vertex.new(0.0, 0.0, 0.0))
        end
        
        it "should return true" do
          @line.intersects_z?(3.0).should be_true
        end
      end
    end
    
    context "for a line that does not intersect the target Z plane" do
      before do
        @line = Line.new(Vertex.new(0.0, 0.0, 4.0), Vertex.new(0.0, 0.0, 6.0))
      end
      
      it "should return false" do
        @line.intersects_z?(3.0).should be_false
      end
    end
  end
  
  describe "#intersection_at_z" do
    context "for a line that intersects the target Z plane" do
      context "and spans both positive and negative space" do
        context "with a positive Z vector" do
          before do
            @line = Line.new(Vertex.new(-1.0, 1.0, 1.0), Vertex.new(1.0, 1.0, -1.0))
          end
          
          it "should return a Point representing the intersection" do
            @line.intersection_at_z(0).x.should == 0.0
            @line.intersection_at_z(0).y.should == 1.0
            @line.intersection_at_z(0).z.should == 0.0
          end
        end
        
        context "with a negative Z vector" do
          before do
            @line = Line.new(Vertex.new(1.0, 1.0, 1.0), Vertex.new(-1.0, -1.0, -1.0))
          end
          
          it "should return a Point representing the intersection" do
            @line.intersection_at_z(0).x.should == 0
            @line.intersection_at_z(0).y.should == 0
            @line.intersection_at_z(0).z.should == 0
          end
        end
      end
    end
      
    context "for a line that lies on the target Z plane" do
      before do
        @line = Line.new(Vertex.new(0.0, 0.0, 3.0), Vertex.new(0.0, 6.0, 3.0))
      end
      
      it "should raise an error" do
        lambda{
          @line.intersection_at_z(3.0)
        }.should raise_error
      end
    end
    
    context "for a line that does not intersect the target Z plane" do
      before do
        @line = Line.new(Vertex.new(0.0, 0.0, 4.0), Vertex.new(0.0, 0.0, 6.0))
      end
      
      it "should return nil" do
        @line.intersection_at_z(3.0).should be_nil
      end
    end
  end
  
  describe "==" do
    it "should return true when the two lines are identical" do
      (Line.new(Vertex.new(-1.0, -1.0, -1.0), Vertex.new(1.0, 1.0, 1.0)) == Line.new(Vertex.new(-1.0, -1.0, -1.0), Vertex.new(1.0, 1.0, 1.0))).should be_true
    end
    
    it "should not return true when the lines are not identical" do
      (Line.new(Vertex.new(-1.0, -1.0, -1.1), Vertex.new(1.0, 1.0, 1.0)) == Line.new(Vertex.new(-1.0, -1.0, -1.0), Vertex.new(1.0, 1.0, 1.0))).should be_false
    end
  end
  
  describe "#to_svg_path" do 
    it "should return a string containing an SVG path" do
      line = Line.new(Vertex.new(0.0, 0.0, 0.0), Vertex.new(1.0, 1.0, 1.0))
      expected_output = '<path d="M 0.0 0.0 L 1.0 1.0" fill="none" stroke="black" stroke-width="0.005" />'
      
      line.to_svg_path(:inches).should == expected_output
    end
  end
end