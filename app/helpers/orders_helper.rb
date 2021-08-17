module OrdersHelper
  def process_buy_stock(order_shares, stock_id)
    stock_for_update = Stock.find_by(id: stock_id)
    stock_for_update.shares -= order_shares
    stock_for_update.save
  end

  def process_sell_stock(stock_id, order_id, current_shares)
    order = Order.find_by(id: order_id)
    stock_for_update = Stock.find_by(id: stock_id)
    stock_for_update.shares += order.shares
    stock_for_update.save
    if current_shares == order.shares
      order.delete
    else
      order.shares = current_shares - order.shares
      order.save
    end
  end
end
