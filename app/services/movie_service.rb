class MovieService
  def top_rated
    get_url("/3/movie/top_rated")
  end

  def search_movies(search)
    get_url("/3/search/movie?query=#{search}")
  end


  def get_url(url, params = {})
  response = conn.get(url, params)
  JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |req|
      req.headers['Authorization'] = "Bearer #{ENV['TMDB_BEARER_TOKEN']}"
    end
  end
end

# If you need to pass api key in as a param
# def conn
#   Faraday.new(url: 'https://api.themoviedb.org') do |f|
#     f.params['api_key'] = ENV['TMBD_API_KEY']
#   end
# end

# def get_url(url)
#   response = conn.get(url)
#   JSON.parse(response.body, symbolize_names: true)
# end