module OrdersHelper
  def process_buy_stock(current_user_id, order_shares, stock_id)
    stock = Stock.find_by(id: stock_id)
    stock.shares -= order_shares
    stock.save

    buyer = User.find_by(id: current_user_id)
    total_price = stock.unit_price * order_shares
    buyer.money -= total_price
    buyer.save
  end

  def process_sell_stock(stock_id, current_user_id, order_id, current_shares)
    order = Order.find_by(id: order_id)
    stock = Stock.find_by(id: stock_id)
    stock.shares += order.shares
    stock.save

    if current_shares == order.shares
      order.delete
    else
      order.shares = current_shares - order.shares
      order.save
    end

    buyer = User.find_by(id: current_user_id)
    total_price = stock.unit_price * current_shares
    buyer.money += total_price
    buyer.save
  end
end
