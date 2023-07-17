class UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:error] = "Invalid input"
      redirect_to new_user_path
    end
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to user_path(@user)
  #   elsif @user.name.empty? || @user.email.empty? || @user.password.empty? || @user.password_confirmation..empty?
  #     flash[:error] = "Missing required information"
  #     redirect_to new_user_path
  #   else
  #     flash[:error] = "Invalid input"
  #     redirect_to new_user_path
  #   end
  # end

  def show
    @facade = MovieFacade
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
