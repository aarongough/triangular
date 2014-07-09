Feature: command line tool

    Scenario: convert SLI to INC
        When I run `triangular convert ../../spec/fixtures/test_binary_cube.stl`
        Then I should see the right inc content
