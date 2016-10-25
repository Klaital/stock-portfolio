class AddIndicesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :email, unique: true
    add_index :users, :slug, unique: true
  end
end
