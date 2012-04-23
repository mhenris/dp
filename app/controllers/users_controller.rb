class UsersController < ApplicationController
  def show
    @title = "Profile"
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    @title = "Edit Profile"
  end

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def follow
    f = Follow.new(:follower => current_user, :following_id => params[:id])
    f.save
    redirect_to user_path(params[:id])
  end
    
end
