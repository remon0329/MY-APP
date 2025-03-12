class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true
  belongs_to :sureddo, optional: true
  belongs_to :comment, optional: true

  # 通知を送ったユーザー
  belongs_to :visitor, class_name: 'User'
  # 通知を送られたユーザー
  belongs_to :visited, class_name: 'User'
end
