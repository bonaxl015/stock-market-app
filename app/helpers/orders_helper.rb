module OrdersHelper

  def process_buy_stock(order_shares, stock_id)
    stock_for_update = Stock.find_by(id: stock_id)
    stock_for_update.shares -= order_shares
    stock_for_update.save
  end

  def process_sell_stock(order_shares, stock_id)
    stock_for_update = Stock.find_by(id: stock_id)
    stock_for_update.shares += order_shares
    stock_for_update.save
  end
end
