require 'triangular/point'
require 'triangular/vertex'
require 'triangular/vector'
require 'triangular/line'
require 'triangular/polyline'
require 'triangular/facet'
require 'triangular/solid'

module Triangular
  def self.parse(string)
    Solid.parse(string)
  end
  
  def self.parse_file(path)
    File.open(path) do |file|
      Solid.parse(file.read)
    end
  end
end
