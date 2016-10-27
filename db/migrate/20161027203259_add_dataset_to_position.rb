class AddDatasetToPosition < ActiveRecord::Migration[5.0]
  def change
    change_table :stock_positions do |t|
      t.string :dataset
    end
  end
end
