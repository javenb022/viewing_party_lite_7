class MovieFacade
  def initialize(search)
    @search = search
  end

  def top_5_movies
    service = MovieService.new

    json = service.top_rated
  end
end