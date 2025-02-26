class AddPredefinedTagsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :predefined_tags, :string
  end
end
