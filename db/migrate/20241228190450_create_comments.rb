class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text "content"
      t.bigint "post_id"
      t.bigint "sureddo_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "user_id", null: false
      t.index [ "post_id" ], name: "index_comments_on_post_id"
      t.index [ "sureddo_id" ], name: "index_comments_on_sureddo_id"
      t.index [ "user_id" ], name: "index_comments_on_user_id"
    end

    add_foreign_key "comments", "posts"
    add_foreign_key "comments", "sureddos"
    add_foreign_key "comments", "users"
  end
end
