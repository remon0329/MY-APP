class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :thumbnail
      t.string :user_name

      t.timestamps
    end
  end
end