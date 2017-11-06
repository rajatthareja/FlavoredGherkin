require_relative '../lib/flavored_gherkin'

FlavoredGherkin.title = 'Flavored Gherkin Sample'
FlavoredGherkin.output_path = 'sample/'
FlavoredGherkin.build 'testing/fixtures/features'
