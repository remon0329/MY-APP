class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :thumbnail
      t.string :user_name
      t.string :video_url # 動画のURLを保存するカラムを追加
      t.text :description # 説明欄を追加

      t.timestamps
    end
  end
end
