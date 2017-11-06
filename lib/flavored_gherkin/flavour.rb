require 'gherkin/parser'

module FlavoredGherkin
  ##
  # Base for Flavored Gherkin Flavours
  #
  class Flavour
    def get_gherkins(feature_files)
      parser = Gherkin::Parser.new
      feature_files.map do |file|
        begin
          gherkin = parser.parse(File.read(file))
          gherkin[:file] = file
          gherkin
        rescue
          puts "Skipping:: Invalid gherkin feature file #{file}"
        end
      end
    end
  end
end
