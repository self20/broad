class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    "https://thumbs.picyo.me/200x0/filters:quality(50)/#{omdb_details['poster']}"
  end

  def imdb_url
    Services::Imdb.new(imdb_id).url
  end

  def rt_url
    "http://www.rottentomatoes.com/search/?search=#{title}"
  end
end