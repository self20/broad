module ViewObjects
  class MovieSearchDetails
    def initialize(imdb_id)
      @imdb_id = imdb_id
    end

    def title
      trakt_data['movie']['title']
    end

    private

    def trakt_data
      @trakt_data ||= Services::Trakt::Search.new.id(@imdb_id).first
    end
  end
end
