module Users
  class MoviesController < ApplicationController
    def index
      @user = User.find(params[:id])
    end
  end
end
