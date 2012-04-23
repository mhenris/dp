class ImagesController < ApplicationController
  def new
    @title = "New Image"
  end

  def create
    @p = Image.new(params[:image])
    @p.user = current_user
    @p.save
    redirect_to user_path(current_user)
  end
end
