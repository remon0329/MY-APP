class UsersController < ApplicationController
  before_action :authenticate_user! # ログインしていることを確認

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: "名前が更新されました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
