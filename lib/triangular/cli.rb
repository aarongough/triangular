require 'thor'

module Triangular
  class CLI < Thor
    desc "convert FILE", "convert STL into specified format, INC for povray or STL in ASCII."
    method_option :to, alias: '-t', type: :string, desc: "specify format (inc/stl)", default: 'inc'
    def convert(filename)
      solid = Triangular.parse_file(filename)
      if options[:to] == 'inc'
        puts solid.to_inc
      else
        puts solid.to_s
      end
    end
  end
end
