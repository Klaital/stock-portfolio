class CreateStockPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_positions do |t|
      t.belongs_to :user, index: true
      t.string :symbol
      t.integer :qty
      t.timestamp :purchase_date
      t.integer :purchase_price
      t.integer :commission
      t.integer :current_price
      t.timestamp :last_updated

      t.timestamps
    end
  end
end
