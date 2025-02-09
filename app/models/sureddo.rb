class Sureddo < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  def self.ransackable_attributes(auth_object = nil)
    [ "body", "created_at", "description", "id", "id_value", "thumbnail", "title", "updated_at", "user_id", "user_name", "image" ]
  end

  def tag_list=(tags)
    self.tags = tags.split(",").map { |tag| Tag.find_or_create_by(name: tag.strip) }
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
