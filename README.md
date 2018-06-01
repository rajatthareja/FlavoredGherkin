# FlavoredGherkin

[![Gem Version](https://badge.fury.io/rb/flavored_gherkin.svg)](https://badge.fury.io/rb/flavored_gherkin)
[![Build status](https://travis-ci.org/rajatthareja/FlavoredGherkin.svg?branch=master)](https://travis-ci.org/rajatthareja/FlavoredGherkin)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/agvyur7bg5ul1444/branch/master?svg=true)](https://ci.appveyor.com/project/rajatthareja/flavoredgherkin)
 

Ruby gem to convert gherkin feature files into html and pdf flavour.

**[Html Flavour Sample](https://flavoredgherkin.rajatthareja.com/sample/Flavored_Gherkin_Sample.html)**

**[Pdf Flavour Sample](https://flavoredgherkin.rajatthareja.com/sample/Flavored_Gherkin_Sample.pdf)**

**More flavours coming soon!**

## Installation

```bash

gem install flavored_gherkin

```

## Information

* RDoc documentation [available on RubyDoc.info](http://www.rubydoc.info/gems/flavored_gherkin)
* Source code [available on GitHub](https://github.com/rajatthareja/FlavoredGherkin)

## Usage

### Options:

| Option                    | Type        | Default                    | Values                        |
|---------------------------|-------------|----------------------------|-------------------------------|
| title                     | [String]    | 'Flavored Gherkin'         | Flavored Gherkin Title        |
| feature_path / input_path | [String]    | Present Working Directory  | Feature Files Path            |
| output_path               | [String]    | Present Working Directory  | Flavored Gherkin Output Path  |
| flavour                   | [String]    | 'Html'                     | 'Html' or 'Pdf'               |

### Code Examples:

```ruby

     require 'flavored_gherkin'
    
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
    FlavoredGherkin.flavour  = 'pdf'
    
    FlavoredGherkin.build
                
```

### CLI Options:

| Option                     | Values        | Explanation                    |
|----------------------------|---------------|--------------------------------|
| -t, --source               | TITLE         | Flavored Gherkin Title         |
| -f, --features / -i, --in  | FEATURE_PATH  | Feature Files Path             |
| -o, --out                  | OUTPUT_PATH   | Flavored Gherkin Output Path   |
| -F, --flavour              | FLAVOUR       | 'Html' or 'Pdf'                |

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
