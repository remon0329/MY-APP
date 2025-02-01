class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :update, :destroy, :new, :show ]
  before_action :set_post, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.all
    if params[:query].present?
      @posts = @posts.where("title LIKE ?", "%#{params[:query]}%")
    end
  end

  def sureddo
    @posts = Post.all
    @sureddos = Sureddo.all
  end

  def top
    @q = Post.ransack(params[:q])
    if params[:q].present?
      @posts = @q.result(distinct: true)
    else
      @posts = Post.all
    end
  end

  def search
    @q = Post.ransack(title_cont: params[:q])
    @posts = @q.result(distinct: true) # 検索結果を取得
    respond_to do |format|
      format.js
      format.json { render json: @posts.pluck(:title) }
      format.html { render :search }
    end
  end

  def new
    @post = Post.new
  end

  def sureddo_new
    @sureddo = Sureddo.new
  end

  def detail
    @post = Post.find(params[:id])
    @comments = @post.comments
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

  def edit
    # @post は before_action で設定される
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "投稿が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.destroy
    redirect_to root_path, notice: "投稿が削除されました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :video_url, :video_file)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def search_posts(query)
    conditions = [
        "title ILIKE ?",
        "title ILIKE ?",
        "title ILIKE ?",
        "title ILIKE ?" ]

    search_queries = [
        "%#{query}%",
        "%#{query.tr('ぁ-ん', 'ァ-ン')}%",
        "%#{query.tr('ァ-ン', 'ぁ-ん')}%",
        "%#{query.tr('a-zA-Z', '')}%" ]

    posts = Post.where(conditions.join(" OR "), *search_queries)
                # AIが生成した投稿は（userテーブルと結合して検索し、投稿IDを取得してから）除外
                .where.not(id: Post.joins(:user).where(users: { name: "OPEN_AI_ANSWER" }).select(:id))

    if query.match?(/[a-zA-Z]/)
        posts = posts.where("title ILIKE ?", "%#{query}%")
    end
    posts
  end
end
