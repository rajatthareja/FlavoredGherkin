Gem::Specification.new do |s|
  s.name        = 'flavored_gherkin'
  s.version     = '0.1'
  s.bindir      = 'bin'
  s.summary     = 'FlavoredGherkin'
  s.description = 'Ruby gem to convert gherkin feature files into html flavour.'
  s.post_install_message = 'More flavours coming soon!'
  s.authors     = ['Rajat Thareja']
  s.email       = 'rajat.thareja.1990@gmail.com'
  s.homepage    = 'http://flavoredgherkin.rajatthareja.com'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 1.9.1'

  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(sample/|css/|js/|pkg/|testing/|coverage/|CNAME|.gitignore|appveyor.yml|.travis.yml|_config.yml|Gemfile|Rakefile|fg.ico)}) }
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files  = s.files.grep(%r{^(testing)/})

  s.add_runtime_dependency 'gherkin', '>= 4.0.0'

  s.add_development_dependency 'rake', '< 13.0'
  s.add_development_dependency 'rspec', '< 4.0'
end
