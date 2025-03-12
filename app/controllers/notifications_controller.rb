class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.present?  # current_user が nil でないことを確認
      @notifications = current_user.passive_notifications.page(params[:page]).per(20)
      # まだ未確認の通知を既読にする
      @notifications.where(checked: false).each do |notification|
        notification.update_attribute(:checked, true)
      end
    else
      @notifications = []  # current_user が nil なら通知は空にする
    end
  end
end
