class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :post, optional: true
  belongs_to :sureddo, optional: true
end
