class DropComments < ActiveRecord::Migration[6.0]
  def up
    drop_table :comments if table_exists?(:comments)
  end

  def down
  end
end
