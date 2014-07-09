require "bundler/setup"
require "triangular"

include Triangular

RSpec.configure do |config|
  def fixture(filename)
    File.open("#{File.dirname(__FILE__)}/fixtures/#{filename}")
  end
end
