class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    return murray if omdb_details['poster'] == 'N/A'
    "https://thumbs.picyo.me/700x0/#{omdb_details['poster']}"
  end

  def imdb_url
    Services::Imdb.new(imdb_id).url
  end

  def rt_url
    "http://www.rottentomatoes.com/search/?search=#{title}"
  end

  def rt_icon
    (rt_value == 0 || rt_value >= 60) ? 'rt_fresh.png' : 'rt_rotten.png'
  end

  def rt_consensus
    return '' unless omdb_details['tomato_consensus'].present? && omdb_details['tomato_consensus'] != 'N/A'
    "\"#{omdb_details['tomato_consensus']}\""
  end

  def best_release
    return nil unless object.best_release.present?
    MovieReleaseDecorator.decorate object.best_release
  end

  def release_date
    return '-' unless omdb_details.present? && omdb_details['released'] != 'N/A'
    Date.parse(omdb_details["released"])
  end

  def forcable?
    waitlist? && download_at.present? && download_at >= Time.now
  end

  private

  def rt_value
    omdb_details['tomato_meter'].to_i
  end

  def murray
    h.image_url "murray_200x307.jpg"
  end
end
