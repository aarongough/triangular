Feature: command line tool

    Scenario: convert SLI to INC
        Given fixture "test_binary_cube.stl" is copied to testing directory
        When I run `triangular convert test_binary_cube.stl`
        Then I should see the right inc content
