module Triangular
  class Line
    
    attr_accessor :start, :end
    
    def initialize(line_start, line_end)
      @start = line_start
      @end = line_end
    end
  end
end
