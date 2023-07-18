class DashboardController < ApplicationController
  def index
    if current_user 

    else 
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path 
    end 
  end
end