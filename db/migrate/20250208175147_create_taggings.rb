class CreateTaggings < ActiveRecord::Migration[7.2]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :post, foreign_key: true, null: true
      t.references :sureddo, foreign_key: true, null: true
      t.timestamps
    end
  end
end
