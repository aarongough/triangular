require 'triangular/point'
require 'triangular/vertex'
require 'triangular/vector'
require 'triangular/line'
require 'triangular/polyline'
require 'triangular/facet'
require 'triangular/units'
require 'triangular/solid'
require 'triangular/ray'

require 'ptools'

module Triangular
  def self.parse(string)
    Solid.parse(string)
  end
  
  def self.parse_file(path)
    data = File.read path
    if File.binary? path
      Solid.parse_binary data
    else
      Solid.parse data
    end
  end
end
