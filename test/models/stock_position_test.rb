require 'test_helper'

class StockPositionTest < ActiveSupport::TestCase
  def setup
    @position1 = StockPosition.new(
        :symbol => 'DIA',
        :qty    => 226,
        :purchase_date => Time.new(2016, 03, 29),
        :purchase_price => 17720,
        :commission => 995,
        :current_price => 18154
    )
  end

  test "purchase price converts to dollars and strings" do
    assert_equal 177.2, @position1.purchase_price_dollars
    assert_equal "177.20", @position1.purchase_price_string
  end

  test "commission converts to dollars and strings" do
    assert_equal 9.95, @position1.commission_dollars
    assert_equal "9.95", @position1.commission_string
  end

  test "current price converts to dollars and strings" do
    assert_equal 181.54, @position1.current_price_dollars
    assert_equal "181.54", @position1.current_price_string
  end

  test "current value is correctly computed" do
    assert_equal 4101809, @position1.current_value
  end

  test "current value converts to dollars and strings" do
    assert_equal 41018.09, @position1.current_value_dollars
    assert_equal "41,018.09", @position1.current_value_string
  end
end
