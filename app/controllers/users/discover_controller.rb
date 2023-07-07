module Users
  class DiscoverController < ApplicationController
    def index
      @user = User.find(params[:id])

      @facade = MovieFacade.new(params[:search])
    end
  end
end
