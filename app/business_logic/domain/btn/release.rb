module Domain
  module BTN
    class Release < SimpleDelegator
      RESOLUTIONS = ["720p", "1080i", "1080p"]
      SOURCES = ["hdtv", "webrip", "web-dl"]

      extend Comparable

      # TODO No tests. Tested through the Domain::BTN::Episode class
      def killer?
        resolution == '1080p'
      end

      def exists?
        Faraday.head(url).headers.key? 'content-disposition'
      end

      def <=>(other)
        resolution_comparison = resolution_points <=> other.resolution_points
        return resolution_comparison unless resolution_comparison == 0
        source_points <=> other.source_points
      end

      def resolution_points
        RESOLUTIONS.index(resolution) || -1
      end

      def source_points
        SOURCES.index(source) || -1
      end
    end
  end
end
