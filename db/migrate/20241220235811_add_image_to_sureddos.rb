class AddImageToSureddos < ActiveRecord::Migration[7.2]
  def change
    add_column :sureddos, :image, :string
  end
end
