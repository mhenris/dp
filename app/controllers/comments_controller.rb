class CommentsController < ApplicationController
  def create
    comment = Comment.new(params[:comment]);
    comment.save
    redirect_to root_path
  end

  def update
  end
end
