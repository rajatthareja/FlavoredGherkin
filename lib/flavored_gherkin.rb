require 'pathname'
require_relative 'flavored_gherkin/html_flavour'

##
# Flavored Gherkin
#
module FlavoredGherkin
  ##
  # Configure Flavored Gherkin
  #
  # Example:
  #
  #     FlavoredGherkin.configure do |config|
  #       config.title = 'My Features'
  #       config.feature_path = 'myFolder/features'
  #       config.output_path = 'myFolder/my_features'
  #     end
  #
  def self.configure
    options = OpenStruct.new
    yield options if block_given?
    @options ||= {}
    @options.merge! options.marshal_dump
  end

  ##
  # Set Flavored Gherkin Options
  #
  # @param [String] option
  # @param [String] value
  #
  # Example:
  #
  #     FlavoredGherkin.set('title', 'My Features')
  #
  def self.set(option, value)
    @options ||= {}
    @options[option.to_sym] = value
  end

  ##
  # Set Flavored Gherkin Flavour
  #
  # @param [String] flavour Flavored Gherkin Flavour
  #
  # Example:
  #
  #     FlavoredGherkin.flavour = 'HtmlFlavour'
  #
  def self.flavour=(flavour)
    @options ||= {}
    @options[:flavour] = flavour
  end

  ##
  # Set Flavored Gherkin Title
  #
  # @param [String] title Flavored Gherkin Title
  #
  # Example:
  #
  #     FlavoredGherkin.title = 'My Features'
  #
  def self.title=(title)
    @options ||= {}
    @options[:title] = title
  end

  ##
  # Set Feature Files Path
  #
  # @param [String] feature_path feature files path
  #
  # Example:
  #
  #     FlavoredGherkin.feature_path = 'muFolder/features'
  #
  def self.feature_path=(feature_path)
    @options ||= {}
    @options[:feature_path] = feature_path
  end

  ##
  # Set Feature Files Path
  #
  # @param [String] input_path feature files path
  #
  # Example:
  #
  #     FlavoredGherkin.input_path = 'muFolder/features'
  #
  def self.input_path=(input_path)
    @options ||= {}
    @options[:input_path] = input_path
  end

  ##
  # Set Flavored Gherkin Output Path
  #
  # @param [String] output_path Flavored Gherkin Output Path
  #
  # Example:
  #
  #     FlavoredGherkin.output_path = 'myFolder/my_features'
  #
  def self.output_path=(output_path)
    @options ||= {}
    @options[:output_path] = output_path
  end

  ##
  # Build Flavored Gherkin
  #
  # Examples:
  #
  #     FlavoredGherkin.build
  #
  #     FlavoredGherkin.build 'muFolder/features'
  #
  #     FlavoredGherkin.build feature_path: 'muFolder/features', title: 'My Features'
  #
  def self.build(options = {})
    @options ||= {}
    if options.is_a? String
      @options[:input_path] = options
    elsif options.is_a? Hash
      @options.merge! options
    end
    const_get(flavour).new.build title, feature_files, output_path
  end

  ##
  # Returns Favour of Flavored Gherkin
  #
  # @return [String] Favour
  #
  def self.flavour
    @options ||= {}
    ['HtmlFlavour'].include?(@options[:flavour]) ? @options[:flavour] : 'HtmlFlavour'
  end

  ##
  # Returns Title of Flavored Gherkin
  #
  # @return [String] Title
  #
  def self.title
    @options ||= {}
    @options[:title] || (@options[:feature_path] || @options[:input_path] || 'Gherkin/Flavored').split('/').reverse[0..5].join(' ').gsub('.', '')
  end

  ##
  # Returns List of Feature Files
  #
  # @return [Array] List of Feature Files
  #
  def self.feature_files
    @options ||= {}
    feature_path = @options[:feature_path] || @options[:input_path] || Dir.pwd
    if Pathname.new(feature_path).directory?
      Dir.glob("#{feature_path}/**/*.feature")
    elsif Pathname.new(feature_path).file?
      [feature_path]
    else
      []
    end
  end

  ##
  # Returns Flavored Gherkin Output Path
  #
  # @return [String] Output Path with file name without extension
  #
  def self.output_path
    @options ||= {}
    output_path = @options[:output_path] ||= Dir.pwd + '/'
    if output_path =~ /.*[\/\\]$/
      unless Pathname(output_path).exist?
        FileUtils.mkpath output_path
      end
      output_path += title.strip.gsub(' ', '_')
    end
    output_path
  end
end
