json.extract! stock_position, :id, :symbol, :qty, :purchase_date, :purchase_price, :commission, :current_price, :last_updated, :created_at, :updated_at
json.url stock_position_url(stock_position, format: :json)