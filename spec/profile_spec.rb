require 'spec_helper'

describe "profile" do
  it "profiles parsing a file" do
    $profile = RubyProf.profile do
      Triangular.parse_file(File.expand_path("#{File.dirname(__FILE__)}/fixtures/y-axis-spacer.stl"))
    end
  end
end