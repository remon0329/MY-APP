class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]
  def index
    @posts = Post.all
    @sureddos = Sureddo.all
  end

  def sureddo
    @posts = Post.all
    @sureddos = Sureddo.all
  end

  def top
    @posts = Post.all # すべての投稿を取得
    @sureddos = Sureddo.all
  end

  def new
    @post = Post.new
  end

  def show
    @user = current_user
    @posts = @user.posts
    @sureddos = @user.sureddos
  end

  def create
    puts current_user.inspect
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    @post.user_name = current_user.name
    if @post.save
      redirect_to root_path, notice: "投稿が作成されました"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :video_url, :video_file)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
