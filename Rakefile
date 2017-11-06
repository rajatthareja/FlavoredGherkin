require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

namespace 'flavored_gherkin' do
  desc 'Test Flavored Gherkin'
  RSpec::Core::RakeTask.new(:test_everything) do |t, _args|
    t.rspec_opts = '--pattern testing/rspec/spec/**/*_spec.rb'
  end
end

task default: 'flavored_gherkin:test_everything'
