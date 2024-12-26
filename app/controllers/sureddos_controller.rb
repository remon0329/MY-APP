class SureddosController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :update, :destroy ]
  before_action :set_sureddo, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
    @sureddos = Sureddo.all
  end

  def new
    @sureddo = Sureddo.new
  end

  def show
    @sureddo = Sureddo.find(params[:id])  # 特定のsureddoを取得
    @comments = @sureddo.comments  # このsureddoに関連するコメントを取得
  end

  def create
    @sureddo = current_user.sureddos.build(sureddo_params)
    @sureddo.user_id = current_user.id
    @sureddo.user_name = current_user.name
    if @sureddo.save
      redirect_to sureddos_path, notice: "投稿が作成されました"
    else
      render :new
    end
  end

  def edit
    # @sureddoはbefore_actionでセットされる
  end

  def update
    if @sureddo.update(sureddo_params)
      redirect_to sureddos_path, notice: "投稿が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @sureddo = Sureddo.find(params[:id])
    @sureddo.comments.destroy_all
    @sureddo.destroy
    redirect_to sureddos_path, notice: "投稿が削除されました"
  end

  private

  def set_sureddo
    @sureddo = Sureddo.find(params[:id])  # 特定のsureddoを取得
  end

  def sureddo_params
    params.require(:sureddo).permit(:title, :description, :image)
  end
end
