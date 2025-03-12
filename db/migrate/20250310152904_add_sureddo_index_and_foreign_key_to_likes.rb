class AddSureddoIndexAndForeignKeyToLikes < ActiveRecord::Migration[7.2]
  def change
    # sureddo_id にインデックスを追加
    add_index :likes, :sureddo_id

    # sureddo_id に外部キー制約を追加
    add_foreign_key :likes, :sureddos
  end
end
