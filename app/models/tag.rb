class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  has_many :sureddos, through: :taggings
  validates :name, presence: true, uniqueness: true
end
