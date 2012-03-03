class UsersController < ApplicationController
  def show
    @title = "Profile"
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign Up"
  end
end
