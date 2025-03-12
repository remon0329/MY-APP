class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:post_id]
      # Postに対するいいね処理
      @post = Post.find(params[:post_id])
      like = current_user.likes.new(post: @post)
      like.save
      @post.create_notification_like!(current_user)
      redirect_to root_path
    elsif params[:sureddo_id]
      # Sureddoに対するいいね処理
      @sureddo = Sureddo.find(params[:sureddo_id])
      like = current_user.likes.new(sureddo: @sureddo)
      like.save
      @sureddo.create_notification_like!(current_user)
      redirect_to sureddos_path
    end
  end

  def destroy
    if params[:post_id]
      # Postに対するいいね解除処理
      @post = Post.find(params[:post_id])
      like = current_user.likes.find_by(post: @post)
      like.destroy if like
      redirect_to root_path
    elsif params[:sureddo_id]
      # Sureddoに対するいいね解除処理
      @sureddo = Sureddo.find(params[:sureddo_id])
      like = current_user.likes.find_by(sureddo: @sureddo)
      like.destroy if like
      redirect_to sureddos_path
    end
  end
end
