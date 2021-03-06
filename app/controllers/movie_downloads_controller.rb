class MovieDownloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render 'new'
  end

  def create
    @view = Domain::PTP::Movie.new(build_movie)
    @view.fetch_new_releases
    @view.has_acceptable_release? ? create_acceptable_release : create_unacceptable_release
  end

  def index
    @view = MovieDecorator.decorate_collection(ViewObjects::Movies.downloadable.paginate(page: params[:page]))
    respond_index
  end

  def download
    movie = Movie.eager_load(:releases).find_by(id: params[:id], key: params[:key])
    @view = Domain::PTP::Movie.new(movie)
    redirect_to @view.best_release.download_url
  end

  private

  def movie_scope
    Movie.downloadable
  end

  def respond_index
    respond_to do |format|
      format.rss {render :layout => false}
      format.html
    end
  end

  def build_movie
    imdb = Services::Imdb.from_data(create_params[:query])
    Movie.find_or_initialize_by(imdb_id: imdb.id) do |movie|
      movie.download_at = Time.now
    end
  end

  def create_acceptable_release
    @view.save
    redirect_to movie_downloads_path and return
  end

  def create_unacceptable_release
  end

  def create_params
    params.permit(:query)
  end
end
