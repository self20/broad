module Services
  # TODO This doesn't belong here
  class Imdb
    ID_REGEXP = /tt[0-9]+/
    URL_REGEXP = /imdb.com\/title\/(tt[0-9]+)/
    URL = "http://www.imdb.com"

    def self.matches?(data)
      URL_REGEXP =~ data || ID_REGEXP =~ data
    end

    def self.from_data(data)
      raise InvalidDataError unless matches?(data)

      if URL_REGEXP =~ data
        return from_url(data)
      elsif ID_REGEXP =~ data
        return new(data)
      end
    end

    def self.from_url(url)
      matches = URL_REGEXP.match(url)
      raise InvalidUrlError unless matches
      new(matches[1])
    end

    attr_reader :imdb_id
    alias_method :query, :imdb_id
    alias_method :id, :imdb_id

    def initialize(imdb_id)
      @imdb_id = imdb_id
    end

    def url
      "#{URL}/title/#{@imdb_id}/"
    end

    class InvalidUrlError < StandardError; end
    class InvalidDataError < StandardError; end
  end
end
