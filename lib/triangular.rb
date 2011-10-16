require 'triangular/point'
require 'triangular/vertex'
require 'triangular/vector'
require 'triangular/facet'
require 'triangular/solid'

module Triangular
  def parse(string)
    Solid.parse(string)
  end
  
  def parse_file(path)
    File.open(path) do |file|
      Solid.parse(file.read)
    end
  end
end
