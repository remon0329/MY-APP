class AddUserIdAndThumbnailToSureddos < ActiveRecord::Migration[7.2]
  def change
    add_column :sureddos, :user_id, :integer
    add_column :sureddos, :thumbnail, :string
  end
end
