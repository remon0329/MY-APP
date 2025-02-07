class ChangePostIdInLikes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :likes, :post_id, true
  end
end
