class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user! # 認証が必要

  private

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "管理者のみアクセス可能です"
      redirect_to root_path
    end
  end
end
