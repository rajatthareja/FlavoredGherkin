require 'erb'
require_relative 'flavour'

module FlavoredGherkin
  ##
  # Html Flavored Gherkin
  #
  class HtmlFlavour < Flavour
    ##
    # Build Html Flavored Gherkin
    #
    def build(title, feature_files, output_path)
      gherkins = get_gherkins feature_files
      raise "Error:: No valid gherkin feature file found #{feature_files}" if gherkins.empty?
      File.open("#{output_path}.html", 'w') do |file|
        file.write get('html_flavour').result(binding).gsub('  ', '').gsub("\n\n", '')
      end
    end

    private

    def get(template)
      @erb ||= {}
      @erb[template] ||= ERB.new(File.read(File.dirname(__FILE__) + '/../../template/' + template + '.erb'), nil, nil, '_' + template)
    end
  end
end
