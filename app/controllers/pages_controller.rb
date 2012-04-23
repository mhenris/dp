class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      redirect_to news_path
    end
  end

  def news
    @title = "News"
    @posts = Post.order("id DESC").all
  end
end
