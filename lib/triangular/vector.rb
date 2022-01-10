# frozen_string_literal: true

module Triangular
  class Vector < Point
    def angle_to(other_vector)
      dot_product = @x * other_vector.x + @y * other_vector.y + @z * other_vector.z
      radians = Math.acos(dot_product)
      radians * (180.0 / Math::PI)
    end
  end
end
