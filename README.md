# Triangular

Triangular is an easy-to-use Ruby library for reading, writing and manipulating Stereolithography (STL) files.

The main purpose of Triangular is to enable its users to quickly create new software for Rapid Prototyping and Personal Manufacturing applications. Triangular has many of the core functions needed in order to generate toolpaths for 3D printers and CNC Mills/Routers.

Please note that Triangular requires Ruby 1.9+. Triangular is currently in the Alpha stage of development which means that the API can and will change, and that new features will be added often!

### A Quick Example
  

```ruby
require "rubygems"
require "triangular"

# Open and parse an STL file
solid = Triangular.parse_file("test.stl")

# Set the units of measurement for the resulting solid to inches
solid.units = :inches

# Move the solid so that all of it's coordinates are in positive space (ie: greater than 0)
solid.align_to_origin!

# Get the bounding box of the solid
bounds = solid.get_bounds

# Create a section plane ('slice') through the solid on the XY plane at a Z height of 0.7
slice = solid.slice_at_z(0.7)

# Open a file for SVG output
File.open("slice.svg", "w+") do |file|

  # Output the slice as an SVG document (correctly scaled according to the solid's units)
  file.puts slice.to_svg(bounds[1].x, bounds[1].y, solid.units)
end
```

### Installation

For ease of use Triangular is packaged as a RubyGem. Providing you already have Ruby and RubyGems installing Triangular is as easy as entering the following command in a terminal:

  `gem install triangular`
  
### Performance

At the moment Triangular has not been optimized at all. The parser is a relatively naive one that was designed to be easy to read rather than performant. Once the feature-set of Triangular has stabilized I will be doing a pass over it in order to make it fast enough for production use. Right now it could definitely be improved.

For example here is some information about run-times when processing a 51Mb STL file:

  ```ruby
  solid = Triangular.parse("big_file.stl")
  # 65 seconds
  
  solid.align_to_origin!
  # 8 seconds
  
  solid.slice_at_z(1.0)
  # 2 seconds
  ```

### Development

To get setup for local development of Triangular please run the following steps:

```
git clone git@github.com:aarongough/triangular.git
cd triangular
bundle install
```

Then run the specs to make sure everything is workin!
```
rpsec
```

### Author & Credits

Author: [Aaron Gough](mailto:aaron@aarongough.com)

Special thanks go out to [Alkas Baybas](https://github.com/abaybas) for lending me his massive brain!

Copyright (c) 2021 [Aaron Gough](http://aarongough.com/) ([http://aarongough.com](http://aarongough.com/)), released under the MIT license

