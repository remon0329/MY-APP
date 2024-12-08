class StaticPagesController < ApplicationController
  def top
    @posts = Post.all
  end
end
