class CreateSureddos < ActiveRecord::Migration[7.2]
  def change
    create_table :sureddos do |t|
      t.string :title
      t.text :description
      t.string :user_name

      t.timestamps
    end
  end
end
