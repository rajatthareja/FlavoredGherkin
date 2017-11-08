`rm Gemfile.lock`

require_relative '../lib/flavored_gherkin'

FlavoredGherkin.title = 'Flavored Gherkin Sample'
FlavoredGherkin.output_path = 'sample/'
FlavoredGherkin.feature_path = 'testing/fixtures/features'

FlavoredGherkin.build
`open sample/Flavored_Gherkin_Sample.html`

`rm sample/Flavored_Gherkin_Sample.pdf`
FlavoredGherkin.flavour = 'pdf'
FlavoredGherkin.build
`open sample/Flavored_Gherkin_Sample.pdf`
