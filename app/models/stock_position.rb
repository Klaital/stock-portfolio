class StockPosition < ApplicationRecord
  belongs_to :user

  # Fetch the latest stock data from Quandl's public API
  def update_from_quandl
    key = user.api_keys.find_by(service: 'Quandl')
    url = "https://www.quandl.com/api/v3/datasets/#{dataset}/#{symbol}.csv?api_key=#{key.secret}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    data = http.get(uri.request_uri)

    if data.code == "200"
      lines = data.body.split("\n")
      newest_date = Date.new(1900,01,01)
      newest_line = nil
      lines.each do |line|
        # Skip the header
        next if line.start_with?("Date,")

        # Look for the actual newest line
        tokens = line.split(',')
        date = Date.parse(tokens[0])
        if date > newest_date
          newest_date = date
          newest_line = line
        end
      end

      if newest_line.nil?
        # TODO: add logging error here
        return nil
      end

      date, open, high, low, close = newest_line.split(',')
      dollars, cents = close.split('.')
      cents = cents.rjust(2,'0')
      current_price = "#{dollars}#{cents}".to_i
      last_updated = newest_date
    end
  end

  ##
  ## Utility Methods for computing value, converting cents to dollar-strings, etc.
  ##

  def purchase_price_dollars
    purchase_price.to_f / 100.0
  end
  def purchase_price_string
    dollars = (purchase_price / 100).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    pennies = (purchase_price % 100).to_s.rjust(2, '0')
    "#{dollars}.#{pennies}"
  end

  def commission_dollars
    commission.to_f / 100.0
  end
  def commission_string
    dollars = (commission / 100).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    pennies = (commission % 100).to_s.rjust(2, '0')
    "#{dollars}.#{pennies}"
  end

  def current_price_dollars
    current_price.to_f / 100.0
  end
  def current_price_string
    dollars = (current_price / 100).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    pennies = (current_price % 100).to_s.rjust(2, '0')
    "#{dollars}.#{pennies}"
  end

  def current_value
    (current_price * qty) - commission
  end
  def current_value_dollars
    current_value.to_f / 100.0
  end
  def current_value_string
    dollars = (current_value / 100).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    pennies = (current_value % 100).to_s.rjust(2, '0')
    "#{dollars}.#{pennies}"
  end
end
