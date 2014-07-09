require 'spec_helper'

RSpec.describe Line do
  describe "#intersects_z?" do 
    subject { instance.intersects_z? value }

    let(:value) { 3.0 }

    context "for a line that intersects the target Z plane" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 0.0), Vertex.new(0.0, 0.0, 6.0)) }

      it { should eq true }
    end

    context "with a negative Z vector" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 6.0), Vertex.new(0.0, 0.0, 0.0)) }

      it { should eq true }
    end
    
    context "for a line that does not intersect the target Z plane" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 4.0), Vertex.new(0.0, 0.0, 6.0)) }

      it { should eq false }
    end
  end
  
  describe "#intersection_at_z" do
    subject { instance.intersection_at_z value }

    let(:value) { 0 }

    context "for a line that intersects the target Z plane" do
      context "and spans both positive and negative space" do
        context "with a positive Z vector" do
          let(:instance) { Line.new(Vertex.new(-1.0, 1.0, 1.0), Vertex.new(1.0, 1.0, -1.0)) }

          it { should eq Point.new(0.0, 1.0, 0.0) }
        end

        context "with a negative Z vector" do
          let(:instance) { Line.new(Vertex.new(1.0, 1.0, 1.0), Vertex.new(-1.0, -1.0, -1.0)) }

          it { should eq Point.new(0.0, 0.0, 0.0) }
        end
      end
    end
      
    context "for a line that lies on the target Z plane" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 3.0), Vertex.new(0.0, 6.0, 3.0)) }

      it { should be_nil }
    end

    context "for a line that does not intersect the target Z plane" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 4.0), Vertex.new(0.0, 0.0, 6.0)) }

      it { should be_nil }
    end
  end
  
  describe "#intersects_x?" do 
    subject { instance.intersects_x? value }

    let(:value) { 3.0 }

    context "for a line that intersects the target X plane" do
      context "with a positive X vector" do
        let(:instance) { Line.new(Vertex.new(2.0, 0.0, 0.0), Vertex.new(3.2, 0.0, 6.0)) }
        
        it { should eq true }
      end
      
      context "with a negative X vector" do
        let(:instance) { Line.new(Vertex.new(3.2, 0.0, 6.0), Vertex.new(2.0, 0.0, 0.0)) }
        
        it { should eq true }
      end
    end
    
    context "for a line that does not intersect the target X plane" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 4.0), Vertex.new(0.0, 0.0, 6.0)) }
      
      it { should eq false }
    end
  end
  
  describe "#intersection_at_x" do
    subject { instance.intersection_at_x value }

    let(:value) { 0 }

    context "for a line that intersects the target X plane" do
      context "and spans both positive and negative space" do
        context "with a positive X vector" do
          let(:instance) { Line.new(Vertex.new(-1.0, 2.0, 1.0), Vertex.new(1.0, 2.0, -1.0)) }
          
          it { should eq Point.new(0.0, 2.0, 0.0) }
        end
        
        context "with a negative X vector" do
          let(:instance) { Line.new(Vertex.new(1.0, 1.0, 1.0), Vertex.new(-1.0, -1.0, -1.0)) }

          it { should eq Point.new(0.0, 0.0, 0.0) }
        end
      end
    end
      
    context "for a line that lies on the target X plane" do
      let(:instance) { Line.new(Vertex.new(3.0, 0.0, 3.0), Vertex.new(3.0, 6.0, 6.0)) }
      let(:value) { 3.0 }
      
      it { should be_nil }
    end
    
    context "for a line that does not intersect the target X plane" do
      let(:instance) { Line.new(Vertex.new(4.0, 0.0, 4.0), Vertex.new(6.0, 0.0, 6.0)) }
      let(:value) { 3.0 }

      it { should be_nil }
    end
  end
  
  describe "#intersects_y?" do 
    subject { instance.intersects_y? value }

    let(:value) { 3.0 }

    context "for a line that intersects the target Y plane" do
      context "with a positive Y vector" do
        let(:instance) { Line.new(Vertex.new(0.0, 2.0, 0.0), Vertex.new(0.0, 3.1, 6.0)) }
        
        it { should eq true }
      end
      
      context "with a negative Y vector" do
        let(:instance) { Line.new(Vertex.new(0.0, 3.1, 6.0), Vertex.new(0.0, 2.0, 0.0)) }
        
        it { should eq true }
      end
    end
    
    context "for a line that does not intersect the target Y plane" do
      let(:instance) { Line.new(Vertex.new(0.0, 0.0, 4.0), Vertex.new(0.0, 0.0, 6.0)) }
      
      it { should eq false }
    end
  end
  
  describe "#intersection_at_y" do
    subject { instance.intersection_at_y value }

    let(:value) { 0 }

    context "for a line that intersects the target Y plane" do
      context "and spans both positive and negative space" do
        context "with a positive Y vector" do
          let(:instance) { Line.new(Vertex.new(2.0, -1.0, 1.0), Vertex.new(2.0, 1.0, -1.0)) }
          
          it { should eq Point.new(2.0, 0.0, 0.0) }
        end
        
        context "with a negative Y vector" do
          let(:instance) { Line.new(Vertex.new(1.0, 1.0, 1.0), Vertex.new(-1.0, -1.0, -1.0)) }
          
          it { should eq Point.new(0.0, 0.0, 0.0) }
        end
      end
    end
      
    context "for a line that lies on the target Y plane" do
      let(:instance) { Line.new(Vertex.new(3.0, 3.0, 3.0), Vertex.new(3.0, 3.0, 6.0)) }
      let(:value) { 3.0 }
      
      it { should be_nil }
    end
    
    context "for a line that does not intersect the target Y plane" do
      let(:instance) { Line.new(Vertex.new(4.0, 4.0, 4.0), Vertex.new(6.0, 6.0, 6.0)) }
      let(:value) { 3.0 }
      
      it { should be_nil }
    end
  end
  
  describe "==" do
    subject { instance == line }

    let(:instance) { Line.new(Vertex.new(-1.0, -1.0, -1.0), Vertex.new(1.0, 1.0, 1.0)) }

    context "when the line has identical values" do
      let(:line) { Line.new(Vertex.new(-1.0, -1.0, -1.0), Vertex.new(1.0, 1.0, 1.0)) }

      it { should eq true }
    end

    context "when the line has different values" do
      let(:line) { Line.new(Vertex.new(-1.0, -1.0, -1.1), Vertex.new(1.0, 1.0, 1.0)) }

      it { should eq false }
    end
  end
  
  describe "#to_svg_path" do 
    subject { instance.to_svg_path :inches }

    let(:instance) { Line.new(Vertex.new(0.0, 0.0, 0.0), Vertex.new(1.0, 1.0, 1.0)) }

    it { should eq '<path d="M 0.0 0.0 L 1.0 1.0" fill="none" stroke="black" stroke-width="0.005" />' }
  end
end
