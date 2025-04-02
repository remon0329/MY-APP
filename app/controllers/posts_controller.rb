class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :update, :destroy, :new, :show ]
  before_action :set_post, only: [ :edit, :update, :destroy ]
  helper_method :prepare_meta_tags
  before_action :require_admin, only: [ :edit, :update, :destroy ]

  def index
    @q = Post.ransack(params[:q])
    if params[:tag_list].present?
      @posts = Post.joins(:tags).where(tags: { name: params[:tag_list] }).distinct
    else
      if params[:q].present?
        @posts = @q.result(distinct: true)
      else
        @posts = Post.all
      end
    end
  end

  def sureddo
    @posts = Post.all
    @sureddos = Sureddo.all
  end

  def top
    @q = Post.ransack(params[:q])
    if params[:tag_list].present?
      @posts = Post.joins(:tags).where(tags: { name: params[:tag_list] }).distinct
    else
      if params[:q].present?
        @posts = @q.result(distinct: true)
      else
        @posts = Post.all
      end
    end
  end

  def search
    @q = Post.ransack(title_cont: params[:q])
    # タグでの絞り込み
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @posts = tag.posts.distinct
    else
      @posts = @q.result(distinct: true)
    end
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
    prepare_meta_tags(@post)
  end

  def show
    @user = current_user

    @posts = @user.posts
    @sureddos = @user.sureddos
  end

  def like_show
    # ユーザーが「いいね」をしたPostを取得
    @posts = current_user.likes.where.not(post_id: nil).map(&:post)
    # ユーザーが「いいね」をしたSureddoを取得
    @sureddos = current_user.likes.where.not(sureddo_id: nil).map(&:sureddo)
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    @post.user_name = current_user.name

    # predefined_tagsが送信されていれば、それをtag_listとして設定
    if params[:post][:predefined_tags].present?
      predefined_tags = params[:post][:predefined_tags]
      # 既存のタグリストにpredefined_tagsを追加
      @post.tag_list = (predefined_tags.split(",") + params[:post][:tag_list].split(",")).uniq
    else
      @post.tag_list = params[:post][:tag_list].split(",")
    end

    if @post.save
      redirect_to root_path, notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def edit
    # @post は before_action で設定される
  end

  def update
    # 基本的なパラメータを取得
    post_attributes = post_params
    # predefined_tagsが送信されていれば、それをtag_listとして設定
    if params[:post][:predefined_tags].present?
      predefined_tags = params[:post][:predefined_tags]
      @post.predefined_tags = predefined_tags # 現在選択されたジャンルを更新
      # 既存のタグリストにpredefined_tagsを追加
      @post.tag_list = (predefined_tags.split(",") + params[:post][:tag_list].split(",")).uniq
    else
      @post.tag_list = params[:post][:tag_list].split(",")
    end
    # YouTubeの動画URLと動画ファイルが両方送信されていないかチェック
    if params[:post][:video_url].present? && params[:post][:video_file].present?
      @post.errors.add(:base, "YouTubeの動画URLと動画ファイルは同時に更新できません")
      render :edit and return
    end
    if params[:post][:video_url].present?
      @post.video_url = params[:post][:video_url]
      @post.video_file.purge if @post.video_file.attached? # Remove any attached video file
    elsif params[:post][:video_file].present?
      @post.video_file.attach(params[:post][:video_file])
      @post.video_url = nil # Clear any existing video URL
    end
    if @post.update(post_attributes)
      redirect_to post_path(current_user), notice: "投稿が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.destroy
    redirect_to post_path(current_user), notice: "投稿が削除されました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :video_url, :video_file, :tag_list, :predefined_tags)
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

    if query.match?(/[a-zA-Z]/)
        posts = posts.where("title ILIKE ?", "%#{query}%")
    end
    posts
  end

  def prepare_meta_tags(post)
    image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(post.title)}"
    set_meta_tags og: {
                    site_name: "GAMES_MEMORY",
                    title: post.title,
                    description: post.description,
                    type: "website",
                    url: request.original_url,
                    image: image_url,
                    locale: "ja-JP"
                  },
                  twitter: {
                    card: "summary_large_image",
                    image: image_url
                  }
  end
end
