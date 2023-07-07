module Users
  class MoviesController < ApplicationController
    def index
      @user = User.find(params[:id])
    end

    def search
      conn = Faraday.new(url: "https://www.themoviedb.org") do |faraday|
        faraday
      end

      # response = conn.get("/movie/top-rated")
  
      # movies = data[:results][0][:members]
  
      # found_members = members.find_all {|m| m[:last_name] == params[:search]}
      # @member = found_members.first
      # render "welcome/index"
    end
  end
end
