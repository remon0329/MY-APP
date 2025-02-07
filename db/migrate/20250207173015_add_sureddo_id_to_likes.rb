class AddSureddoIdToLikes < ActiveRecord::Migration[7.2]
  def change
    add_column :likes, :sureddo_id, :bigint
  end
end
