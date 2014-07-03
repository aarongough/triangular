Given(/^fixture "([^"]*?)" is copied to testing directory$/) do |filename|
  FileUtils.cp "spec/fixtures/#{filename}", "tmp/aruba/"
end

Then(/^I should see the right inc content$/) do
  expect(all_output).to eq(<<-EOT)
# declare m_0 = mesh {
  triangle {
    <-1.0, 1.0, -1.0>,
    <-1.0, -1.0, -1.0>,
    <-1.0, -1.0, 1.0>
  }
  triangle {
    <-1.0, -1.0, 1.0>,
    <-1.0, 1.0, 1.0>,
    <-1.0, 1.0, -1.0>
  }
  triangle {
    <-1.0, 1.0, 1.0>,
    <1.0, 1.0, 1.0>,
    <1.0, 1.0, -1.0>
  }
  triangle {
    <1.0, 1.0, -1.0>,
    <-1.0, 1.0, -1.0>,
    <-1.0, 1.0, 1.0>
  }
  triangle {
    <1.0, 1.0, 1.0>,
    <1.0, -1.0, 1.0>,
    <1.0, -1.0, -1.0>
  }
  triangle {
    <1.0, -1.0, -1.0>,
    <1.0, 1.0, -1.0>,
    <1.0, 1.0, 1.0>
  }
  triangle {
    <-1.0, -1.0, -1.0>,
    <1.0, -1.0, -1.0>,
    <1.0, -1.0, 1.0>
  }
  triangle {
    <1.0, -1.0, 1.0>,
    <-1.0, -1.0, 1.0>,
    <-1.0, -1.0, -1.0>
  }
  triangle {
    <-1.0, -1.0, -1.0>,
    <-1.0, 1.0, -1.0>,
    <1.0, 1.0, -1.0>
  }
  triangle {
    <1.0, 1.0, -1.0>,
    <1.0, -1.0, -1.0>,
    <-1.0, -1.0, -1.0>
  }
  triangle {
    <1.0, -1.0, 1.0>,
    <1.0, 1.0, 1.0>,
    <-1.0, 1.0, 1.0>
  }
  triangle {
    <-1.0, 1.0, 1.0>,
    <-1.0, -1.0, 1.0>,
    <1.0, -1.0, 1.0>
  }
}
  EOT
end