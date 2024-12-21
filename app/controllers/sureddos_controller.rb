class SureddosController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]

  def index
    @posts = Post.all
    @sureddos = Sureddo.all
  end

  def new
    @sureddo = Sureddo.new
  end

  def show
    @sureddo = Sureddo.find(params[:id])
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

  private

  def sureddo_params
    params.require(:sureddo).permit(:title, :description, :image)
  end
end
