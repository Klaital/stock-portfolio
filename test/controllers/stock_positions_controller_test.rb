require 'test_helper'

class StockPositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_position = stock_positions(:one)
    @user = users(:one)
  end

  test "should get index" do
    get stock_positions_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_position_url
    assert_response :success
  end

  test "should fail to create stock_position without login" do
    assert_no_difference('StockPosition.count') do
      post stock_positions_url, params: { stock_position: {
          commission: @stock_position.commission,
          current_price: @stock_position.current_price,
          last_updated: @stock_position.last_updated,
          purchase_date: @stock_position.purchase_date,
          purchase_price: @stock_position.purchase_price,
          qty: @stock_position.qty,
          symbol: @stock_position.symbol,
          user_id: @user.id
      } }
    end

    # assert_redirected_to stock_position_url(StockPosition.last)
  end

  test "should show stock_position" do
    get stock_position_url(@stock_position)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_position_url(@stock_position)
    assert_response :success
  end

  test "should update stock_position" do
    patch stock_position_url(@stock_position), params: { stock_position: { commission: @stock_position.commission, current_price: @stock_position.current_price, last_updated: @stock_position.last_updated, purchase_date: @stock_position.purchase_date, purchase_price: @stock_position.purchase_price, qty: @stock_position.qty, symbol: @stock_position.symbol } }
    assert_redirected_to stock_position_url(@stock_position)
  end

  test "should destroy stock_position" do
    assert_difference('StockPosition.count', -1) do
      delete stock_position_url(@stock_position)
    end

    assert_redirected_to stock_positions_url
  end
end
