class PostsController < ApplicationController
  def create
    post = Post.new(:user => current_user, :body => params[:post][:body])
    post.save
    redirect_to root_path
  end

  def update
  end
end
