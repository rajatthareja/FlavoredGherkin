require 'tempfile'
require_relative '../../../lib/flavored_gherkin'

describe FlavoredGherkin do
  it 'Build HTML Flavored Gherkin' do
    output_path = Tempfile.new('features').path
    input_path = 'testing/fixtures/features'

    FlavoredGherkin.build input_path: input_path, output_path: output_path

    actual = File.read("#{output_path}.html")
    expected = File.read('testing/fixtures/features.html')

    expect(actual).to eq(expected)
  end
end
