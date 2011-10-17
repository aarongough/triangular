# -*- encoding: utf-8 -*-
require File.expand_path("../lib/triangular/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "triangular"
  s.version     = Triangular::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aaron Gough"]
  s.email       = ["aaron@aarongough.com"]
  s.homepage    = "http://rubygems.org/gems/triangular"
  s.summary     = "[ALPHA] A simple Ruby library for reading, writing, and manipulating Stereolithography (STL) files."
  s.description = "Triangular is an easy-to-use Ruby library for reading, writing and manipulating Stereolithography (STL) files.\n\n The main purpose of Triangular is to enable its users to quickly create new software for Rapid Prototyping and Personal Manufacturing applications. "

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "triangular"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
