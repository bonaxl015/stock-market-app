module StocksHelper
  def process_top_up(amount)
    user = User.find_by(id: current_user.id)
    user.money += amount.to_i
    user.save
  end

  def keep_symbol(stock_symbol)
    # @@symbol = stock_symbol
    Stock.class_variable_set(:@@symbol, stock_symbol)
  end

  def retrieve_symbol
    Stock.class_variable_get(:@@symbol)
  end
end
