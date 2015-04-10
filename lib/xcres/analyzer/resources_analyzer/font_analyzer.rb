require 'xcres/analyzer/resources_analyzer/base_resources_analyzer'

module XCRes
  module ResourcesAnalyzer

    # A +LooseResourcesAnalyzer+ scans the project for resources, which are
    # loosely placed in the project or in a group and should be included in the
    # output file.
    #
    class FontAnalyzer < BaseResourcesAnalyzer

      def analyze
        @sections = [build_sections_for_fonts]
        super
      end

      # Build a section for each asset catalog if it contains any resources
      #
      # @return [Array<Section>]
      #         the built sections
      #
      def build_sections_for_fonts
        font_file_refs = resources_files.map(&:path).select { |path| path.to_s.match /\.(ttf|otf)$/ }

        log 'Found #%s fonts in project.', font_file_refs.count
        fonts = font_file_refs.map { |file| basename_without_ext file }
        data = build_section_data(fonts, options)

        new_section('Fonts', data)
      end

    end

  end
end
