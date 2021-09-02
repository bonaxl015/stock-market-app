module OrdersHelper
  def process_buy_stock(user_id, order_shares, stock_id)
    stock = Stock.find_by(id: stock_id)
    buyer = User.find_by(id: user_id)

    stock.shares -= order_shares
    stock.save
    total_price = stock.unit_price * order_shares
    buyer.money -= total_price
    buyer.save
  end

  def process_sell_stock(stock_id, user_id, order_id, current_shares)
    order = Order.find_by(id: order_id)
    stock = Stock.find_by(id: stock_id)
    buyer = User.find_by(id: user_id)

    stock.shares += order.shares
    stock.save
    total_price = stock.unit_price * order.shares
    if current_shares == order.shares
      order.delete
    else
      order.shares = current_shares - order.shares
      order.save
    end
    buyer.money += total_price
    buyer.save
  end

  def calculate_investments(user_orders)
    total_investments = 0
    unless user_orders.count.zero?
      user_orders.each do |order|
        total_investments += order.shares * order.unit_price
      end
    end
    total_investments.round(2)
  end
end
