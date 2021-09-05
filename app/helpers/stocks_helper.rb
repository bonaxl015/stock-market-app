module StocksHelper
  $symbol = ''

  def process_top_up(amount)
    user = User.find_by(id: current_user.id)
    user.money += amount.to_i
    user.save
  end

  def keep_symbol(stock_symbol)
    $symbol = stock_symbol
  end

  def retrieve_symbol
    $symbol
  end
end
