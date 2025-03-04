class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :video_file
  validate :video_url_or_video_file
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  def self.ransackable_attributes(auth_object = nil)
    [ "body", "created_at", "description", "id", "id_value", "thumbnail", "title", "updated_at", "user_id", "user_name", "video_file", "video_url" ]
  end


  def tag_list=(tags)
    # tagsが配列なら、そのまま使う
    if tags.is_a?(Array)
      self.tags = tags.map { |tag| Tag.find_or_create_by(name: tag.strip) }
    else
      # 文字列の場合はカンマで分割して処理
      self.tags = tags.split(",").map { |tag| Tag.find_or_create_by(name: tag.strip) }
    end
  end

  def liked_by?(user)
    return false if user.nil?
    likes.exists?(user_id: user.id)
  end

  private

  def video_url_or_video_file
    if video_url.blank? && video_file.blank?
      errors.add(:base, "YouTubeの動画URLまたは動画ファイルを入力してください")
    end
  end
end
