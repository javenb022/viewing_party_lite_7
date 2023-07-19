class Admin::DashboardController < ApplicationController
  def index
    @users = User.all
  end
end
