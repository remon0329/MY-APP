class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :video_file
  validates :video_url, format: { with: /\Ahttps:\/\/www\.youtube\.com\/watch\?v=.*\z/, message: "はYouTubeのURLである必要があります" }, allow_blank: true
end
