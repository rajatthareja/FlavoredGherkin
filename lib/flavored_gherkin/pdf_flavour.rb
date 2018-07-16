require 'prawn'
require_relative 'flavour'

module FlavoredGherkin
  ##
  # PDF Flavored Gherkin
  #
  class PdfFlavour < Flavour
    ##
    # Build PDF Flavored Gherkin
    #
    def build(title, feature_files, output_path)
      info = {
        Title: title,
        Author: 'FlavoredGherkin',
        CreationDate: Time.now
      }

      gherkins = Flavour.new.get_gherkins(feature_files)

      tags = {}

      Prawn::Document.generate("#{output_path}.pdf", info: info) do |pdf|
        pdf.font_size 30
        pdf.text title, align: :center, color: '3a5b93', stylr: :bold
        pdf.move_down 30

        pdf.font_size 20
        pdf.text 'Index', color: '3a5b93', stylr: :bold
        pdf.move_down 10

        pdf.font_size 12
        pdf.bounding_box([10, pdf.cursor], width: pdf.bounds.right) do
          gherkins.each_with_index do |g, fid|
            pdf.move_down 10

            pdf.text "<color rgb='3a5b93'>O</color> <link anchor='Feature #{fid}'>#{g[:feature][:name]}</link>", inline_format: true

            pdf.bounding_box([10, pdf.cursor], width: pdf.bounds.right) do
              g[:feature][:children].each_with_index do |scenario, sid|
                next if scenario[:type] == :Background
                pdf.text "<color rgb='3a5b93'>o</color> <link anchor='Scenario #{fid} #{sid}'>#{scenario[:name]}</link>", inline_format: true
              end
            end
          end
        end

        gherkins.each_with_index do |g, fid|
          pdf.start_new_page

          pdf.add_dest "Feature #{fid}", pdf.dest_xyz(pdf.bounds.absolute_left, pdf.y)

          feature_tags = g[:feature][:tags].map { |t| t[:name] }
          pdf.text(feature_tags.join(' '), color: '00695c')
          feature_tags.each do |tag|
            count = 0
            g[:feature][:children].each do |scenario|
              next if scenario[:type] == :Background
              count += scenario[:examples] ? scenario[:examples].map { |e| e[:tableBody] }.flatten.size : 1
            end
            tags[tag] ? tags[tag] += count : tags[tag] = count
          end

          pdf.font_size 14
          pdf.text "<b><color rgb='3a5b93'>" + g[:feature][:keyword] + '</color></b> ' + g[:feature][:name], inline_format: true, style: :bold
          pdf.font_size 12

          pdf.bounding_box([10, pdf.cursor], width: pdf.bounds.right) do
            pdf.text g[:feature][:description]

            g[:feature][:children].each_with_index do |scenario, sid|
              pdf.move_down 10

              pdf.add_dest "Scenario #{fid} #{sid}", pdf.dest_xyz(pdf.bounds.absolute_left, pdf.y)

              if scenario[:tags]
                scenario_tags = scenario[:tags].map { |tag| tag[:name] }
                pdf.text(scenario_tags.join(' '), color: '00695c')
                scenario_tags.each do |tag|
                  count = scenario[:examples] ? scenario[:examples].map { |e| e[:tableBody] }.flatten.size : 1
                  tags[tag] ? tags[tag] += count : tags[tag] = count
                end
              end

              pdf.text "<b><color rgb='3a5b93'>" + scenario[:keyword] + '</color></b> ' + scenario[:name], inline_format: true

              scenario[:steps].each do |step|
                pdf.bounding_box([10, pdf.cursor], width: pdf.bounds.right) do
                  pdf.text "<b><color rgb='3a5b93'>" + step[:keyword] + '</color></b> ' + step[:text].gsub('<', "<color rgb='558b2f'>").gsub('>', '</color>'), inline_format: true

                  if step[:argument]
                    pdf.bounding_box([10, pdf.cursor], width: pdf.bounds.right) do
                      if step[:argument][:rows]
                        step[:argument][:rows].each do |row|
                          pdf.text('| ' + row[:cells].map { |cell| cell[:value] }.join(' | ') + ' |')
                        end
                      end
                      if step[:argument][:content]
                        pdf.text step[:argument][:content], color: '3a5b93', style: :bold
                      end
                    end
                  end
                end
              end
              next unless scenario[:examples]
              scenario[:examples].each do |example|
                pdf.text example[:keyword], color: '3a5b93', style: :bold

                pdf.bounding_box([10, pdf.cursor], width: pdf.bounds.right) do
                  pdf.text('| ' + example[:tableHeader][:cells].map { |cell| cell[:value] }.join(' | ') + ' |', style: :bold, color: '558b2f')
                  example[:tableBody].each do |row|
                    pdf.text('| ' + row[:cells].map { |cell| cell[:value] }.join(' | ') + ' |')
                  end
                end
              end
            end
          end
        end
        pdf.start_new_page

        pdf.font_size 20
        pdf.text 'Tags', color: '3a5b93', stylr: :bold
        pdf.move_down 10

        pdf.font_size 12
        tags.each do |tag, count|
          pdf.text "<b>#{tag} : </b>#{count}", inline_format: true
        end
      end
    end
  end
end