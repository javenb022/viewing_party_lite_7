module Users
  class MoviesController < ApplicationController
    def index
      @user = User.find(params[:id])
      require 'pry'; binding.pry
      @movies = MovieService.new.top_rated
    end
  end
end
