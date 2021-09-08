module StocksHelper
  def process_top_up(amount)
    user = User.find_by(id: current_user.id)
    user.money += amount.to_i
    user.save
  end
end
