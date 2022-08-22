# frozen_string_literal: true

require File.expand_path('lib/triangular/version', __dir__)

Gem::Specification.new do |spec|
  spec.name        = 'triangular'
  spec.version     = Triangular::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Aaron Gough']
  spec.email       = ['aaron@aarongough.com']
  spec.license     = "MIT"
  spec.homepage    = 'http://rubygems.org/gems/triangular'
  spec.summary     = 'A simple Ruby library for reading, writing, and manipulating Stereolithography (STL) files.'
  spec.description = "Triangular is an easy-to-use Ruby library for reading, writing and manipulating Stereolithography (STL) files.\n\n The main purpose of Triangular is to enable its users to quickly create new software for Rapid Prototyping and Personal Manufacturing applications. "

  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rubocop', '~> 1.12'
  spec.add_development_dependency 'ruby-prof', '~> 1.4'
  spec.add_development_dependency 'simplecov', '0.17.1'

  spec.required_ruby_version = '>= 1.9.0'

  spec.files        = `git ls-files`.split("\n")
  spec.executables  = `git ls-files`.split("\n").map { |f| f =~ %r{^bin/(.*)} ? Regexp.last_match(1) : nil }.compact
  spec.require_path = 'lib'
end
