class AddVideoFileToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :video_file, :string
  end
end
