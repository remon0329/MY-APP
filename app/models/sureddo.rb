class Sureddo < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :notifications, dependent: :destroy
  def self.ransackable_attributes(auth_object = nil)
    [ "body", "created_at", "description", "id", "id_value", "thumbnail", "title", "updated_at", "user_id", "user_name", "image" ]
  end

  def tag_list=(tags)
    self.tags = tags.split(",").map { |tag| Tag.find_or_create_by(name: tag.strip) }
  end

  def liked_by?(user)
    return false if user.nil?
    likes.exists?(user_id: user.id)
  end

  def create_notification_like!(current_user)
    temp = Notification.where([ "visitor_id = ? and visited_id = ? and sureddo_id = ? and action = ? ",
                                current_user.id, user_id, id, "like" ])
    return if temp.present?

    notification = current_user.active_notifications.new(
      sureddo_id: id,
      visited_id: user_id,
      action: "sureddo_like"
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(sureddo_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id["user_id"])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      sureddo_id: id,
      comment_id:,
      visited_id:,
      action: "sureddo_comment"
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
