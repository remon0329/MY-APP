class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :video_file
  validates :video_url_or_video_file, presence: { message: "YouTubeの動画URLまたは動画ファイルを入力してください" }

  private

  def video_url_or_video_file
    if video_url.blank? && video_file.blank?
      errors.add(:base, "YouTubeの動画URLまたは動画ファイルを入力してください")
    end
  end
end
