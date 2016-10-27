class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.belongs_to :user
      t.string :service
      t.string :secret

      t.timestamps
    end
  end
end
