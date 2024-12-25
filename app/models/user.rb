class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :posts
  has_many :sureddos
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  validates :name, presence: true
end
