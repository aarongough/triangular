# frozen_string_literal: true

require 'spec_helper'

describe Triangular::Line do
  describe '#intersects_z?' do
    context 'for a line that intersects the target Z plane' do
      context 'with a positive Z vector' do
        before do
          @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 0.0), Triangular::Vertex.new(0.0, 0.0, 6.0))
        end

        it 'should return true' do
          expect(@line.intersects_z?(3.0)).to be true
        end
      end

      context 'with a negative Z vector' do
        before do
          @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 6.0), Triangular::Vertex.new(0.0, 0.0, 0.0))
        end

        it 'should return true' do
          expect(@line.intersects_z?(3.0)).to be true
        end
      end
    end

    context 'for a line that does not intersect the target Z plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 4.0), Triangular::Vertex.new(0.0, 0.0, 6.0))
      end

      it 'should return false' do
        expect(@line.intersects_z?(3.0)).to be false
      end
    end
  end

  describe '#intersection_at_z' do
    context 'for a line that intersects the target Z plane' do
      context 'and spans both positive and negative space' do
        context 'with a positive Z vector' do
          before do
            @line = Triangular::Line.new(Triangular::Vertex.new(-1.0, 1.0, 1.0), Triangular::Vertex.new(1.0, 1.0, -1.0))
          end

          it 'should return a Point representing the intersection' do
            expect(@line.intersection_at_z(0).x).to eq(0.0)
            expect(@line.intersection_at_z(0).y).to eq(1.0)
            expect(@line.intersection_at_z(0).z).to eq(0.0)
          end
        end

        context 'with a negative Z vector' do
          before do
            @line = Triangular::Line.new(Triangular::Vertex.new(1.0, 1.0, 1.0),
                                         Triangular::Vertex.new(-1.0, -1.0, -1.0))
          end

          it 'should return a Point representing the intersection' do
            expect(@line.intersection_at_z(0).x).to eq(0)
            expect(@line.intersection_at_z(0).y).to eq(0)
            expect(@line.intersection_at_z(0).z).to eq(0)
          end
        end
      end
    end

    context 'for a line that lies on the target Z plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 3.0), Triangular::Vertex.new(0.0, 6.0, 3.0))
      end

      it 'should raise an error' do
        expect(@line.intersection_at_z(3.0)).to eq(nil)
      end
    end

    context 'for a line that does not intersect the target Z plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 4.0), Triangular::Vertex.new(0.0, 0.0, 6.0))
      end

      it 'should return nil' do
        expect(@line.intersection_at_z(3.0)).to be_nil
      end
    end
  end

  describe '#intersects_x?' do
    context 'for a line that intersects the target X plane' do
      context 'with a positive X vector' do
        before do
          @line = Triangular::Line.new(Triangular::Vertex.new(2.0, 0.0, 0.0), Triangular::Vertex.new(3.2, 0.0, 6.0))
        end

        it 'should return true' do
          expect(@line.intersects_x?(3.0)).to be true
        end
      end

      context 'with a negative X vector' do
        before do
          @line = Triangular::Line.new(Triangular::Vertex.new(3.2, 0.0, 6.0), Triangular::Vertex.new(2.0, 0.0, 0.0))
        end

        it 'should return true' do
          expect(@line.intersects_x?(3.0)).to be true
        end
      end
    end

    context 'for a line that does not intersect the target X plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 4.0), Triangular::Vertex.new(0.0, 0.0, 6.0))
      end

      it 'should return false' do
        expect(@line.intersects_x?(3.0)).to be false
      end
    end
  end

  describe '#intersection_at_x' do
    context 'for a line that intersects the target X plane' do
      context 'and spans both positive and negative space' do
        context 'with a positive X vector' do
          before do
            @line = Triangular::Line.new(Triangular::Vertex.new(-1.0, 2.0, 1.0), Triangular::Vertex.new(1.0, 2.0, -1.0))
          end

          it 'should return a Point representing the intersection' do
            expect(@line.intersection_at_x(0).x).to eq(0.0)
            expect(@line.intersection_at_x(0).y).to eq(2.0)
            expect(@line.intersection_at_x(0).z).to eq(0.0)
          end
        end

        context 'with a negative X vector' do
          before do
            @line = Triangular::Line.new(Triangular::Vertex.new(1.0, 1.0, 1.0),
                                         Triangular::Vertex.new(-1.0, -1.0, -1.0))
          end

          it 'should return a Point representing the intersection' do
            expect(@line.intersection_at_x(0).x).to eq(0)
            expect(@line.intersection_at_x(0).y).to eq(0)
            expect(@line.intersection_at_x(0).z).to eq(0)
          end
        end
      end
    end

    context 'for a line that lies on the target X plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(3.0, 0.0, 3.0), Triangular::Vertex.new(3.0, 6.0, 6.0))
      end

      it 'should raise an error' do
        expect(@line.intersection_at_x(3.0)).to eq(nil)
      end
    end

    context 'for a line that does not intersect the target X plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(4.0, 0.0, 4.0), Triangular::Vertex.new(6.0, 0.0, 6.0))
      end

      it 'should return nil' do
        expect(@line.intersection_at_x(3.0)).to be_nil
      end
    end
  end

  describe '#intersects_y?' do
    context 'for a line that intersects the target Y plane' do
      context 'with a positive Y vector' do
        before do
          @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 2.0, 0.0), Triangular::Vertex.new(0.0, 3.1, 6.0))
        end

        it 'should return true' do
          expect(@line.intersects_y?(3.0)).to be true
        end
      end

      context 'with a negative Y vector' do
        before do
          @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 3.1, 6.0), Triangular::Vertex.new(0.0, 2.0, 0.0))
        end

        it 'should return true' do
          expect(@line.intersects_y?(3.0)).to be true
        end
      end
    end

    context 'for a line that does not intersect the target Y plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 4.0), Triangular::Vertex.new(0.0, 0.0, 6.0))
      end

      it 'should return false' do
        expect(@line.intersects_y?(3.0)).to be false
      end
    end
  end

  describe '#intersection_at_y' do
    context 'for a line that intersects the target Y plane' do
      context 'and spans both positive and negative space' do
        context 'with a positive Y vector' do
          before do
            @line = Triangular::Line.new(Triangular::Vertex.new(2.0, -1.0, 1.0), Triangular::Vertex.new(2.0, 1.0, -1.0))
          end

          it 'should return a Point representing the intersection' do
            expect(@line.intersection_at_y(0).x).to eq(2.0)
            expect(@line.intersection_at_y(0).y).to eq(0.0)
            expect(@line.intersection_at_y(0).z).to eq(0.0)
          end
        end

        context 'with a negative Y vector' do
          before do
            @line = Triangular::Line.new(Triangular::Vertex.new(1.0, 1.0, 1.0),
                                         Triangular::Vertex.new(-1.0, -1.0, -1.0))
          end

          it 'should return a Point representing the intersection' do
            expect(@line.intersection_at_y(0).x).to eq(0)
            expect(@line.intersection_at_y(0).y).to eq(0)
            expect(@line.intersection_at_y(0).z).to eq(0)
          end
        end
      end
    end

    context 'for a line that lies on the target Y plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(3.0, 3.0, 3.0), Triangular::Vertex.new(3.0, 3.0, 6.0))
      end

      it 'should raise an error' do
        expect(@line.intersection_at_y(3.0)).to eq(nil)
      end
    end

    context 'for a line that does not intersect the target Y plane' do
      before do
        @line = Triangular::Line.new(Triangular::Vertex.new(4.0, 4.0, 4.0), Triangular::Vertex.new(6.0, 6.0, 6.0))
      end

      it 'should return nil' do
        expect(@line.intersection_at_y(3.0)).to be_nil
      end
    end
  end

  describe '==' do
    it 'should return true when the two lines are identical' do
      expect(
        Triangular::Line.new(Triangular::Vertex.new(-1.0, -1.0, -1.0), Triangular::Vertex.new(1.0, 1.0, 1.0)) ==
        Triangular::Line.new(Triangular::Vertex.new(-1.0, -1.0, -1.0), Triangular::Vertex.new(1.0, 1.0, 1.0))
      ).to be true
    end

    it 'should not return true when the lines are not identical' do
      expect(
        Triangular::Line.new(Triangular::Vertex.new(-1.0, -1.0, -1.1), Triangular::Vertex.new(1.0, 1.0, 1.0)) ==
        Triangular::Line.new(Triangular::Vertex.new(-1.0, -1.0, -1.0), Triangular::Vertex.new(1.0, 1.0, 1.0))
      ).to be false
    end
  end

  describe '#to_svg_path' do
    it 'should return a string containing an SVG path' do
      line = Triangular::Line.new(Triangular::Vertex.new(0.0, 0.0, 0.0), Triangular::Vertex.new(1.0, 1.0, 1.0))
      expected_output = '<path d="M 0.0 0.0 L 1.0 1.0" fill="none" stroke="black" stroke-width="0.005" />'

      expect(line.to_svg_path(:inches)).to eq(expected_output)
    end
  end
end
