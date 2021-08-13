class AddDefaultValueFalseToBrokerForUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :broker, from: nil, to: false
  end
end
