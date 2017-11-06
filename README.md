# Flavored Gherkin

[![Gem Version](https://badge.fury.io/rb/flavored_gherkin.svg)](https://badge.fury.io/rb/flavored_gherkin) 

Ruby gem to convert gherkin feature files into html.

**[View Sample](http://flavoredgherkin.rajatthareja.com/sample/Flavored_Gherkin_Sample.html)**

## Installation

```bash

gem install flavored_gherkin

```

## Information

* RDoc documentation [available on RubyDoc.info](http://www.rubydoc.info/gems/flavored_gherkin)
* Source code [available on GitHub](http://github.com/rajatthareja/FlavoredGherkin)

## Usage

### Options:

| Option                    | Type        | Default                    | Values                        |
|---------------------------|-------------|----------------------------|-------------------------------|
| title                     | [String]    | 'Flavored Gherkin'         | Flavored Gherkin Title        |
| feature_path / input_path | [String]    | Present Working Directory  | Feature Files Path            |
| output_path               | [String]    | Present Working Directory  | Flavored Gherkin Output Path  |

### Code Examples:

```ruby

     require 'report_builder'
    
    # Example 1:
    
    FlavoredGherkin.configure do |config|
      config.title = 'My Features'
      config.feature_path = 'myFolder/features'
      config.output_path = 'myFolder/my_features'
    end
    
    FlavoredGherkin.build
    
    # Example 2:
    
    options = {
       title: 'My Features',
       feature_path: 'myFolder/features',
       output_path: 'myFolder/my_features'
     }
    
    FlavoredGherkin.build options
        
    # Example 3:
    
    FlavoredGherkin.set 'title', 'My Features'
    FlavoredGherkin.set 'feature_path', 'myFolder/features'
    FlavoredGherkin.set  'output_path', 'myFolder/my_features'
    
    FlavoredGherkin.build
    
    # Example 4:
    
    FlavoredGherkin.title = 'My Features'
    FlavoredGherkin.feature_path = 'myFolder/features'
    FlavoredGherkin.output_path  = 'myFolder/my_features'
    
    FlavoredGherkin.build
                
```

### CLI Options:

| Option                     | Values        | Explanation                    |
|----------------------------|---------------|--------------------------------|
| -t, --source               | TITLE         | Flavored Gherkin Title         |
| -f, --features / -i, --in  | FEATURE_PATH  | Feature Files Path             |
| -o, --out                  | OUTPUT_PATH   | Flavored Gherkin Output Path   |

### CLI Example:

```bash

     flavored_gherkin
     
     flavored_gherkin -f 'myFolder/features'
     
     flavored_gherkin -t 'My Features' -f 'myFolder/features' -o 'myFolder/my_features'

```

## Contributing

We're open to any contribution. It has to be tested properly though.

## Collaborators

* [Rajat Thareja](http://rajatthareja.com)

## License

Copyright (c) 2017 [MIT LICENSE](LICENSE)
