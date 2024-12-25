class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create_for_post
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to detail_post_path(@post), notice: "コメントが投稿されました"
    else
      flash.now[:alert] = @comment.errors.full_messages.join(", ")
      redirect_to detail_post_path(@post), alert: "コメントの投稿に失敗しました"
    end
  end

  def create_for_sureddo
    @sureddo = Sureddo.find(params[:sureddo_id])
    @comment = @sureddo.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to sureddo_path(@sureddo), notice: "コメントが投稿されました"
    else
      flash.now[:alert] = @comment.errors.full_messages.join(", ")
      redirect_to sureddo_path(@sureddo), alert: "コメントの投稿に失敗しました"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
