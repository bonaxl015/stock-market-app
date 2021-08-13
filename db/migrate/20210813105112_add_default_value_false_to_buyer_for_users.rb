class AddDefaultValueFalseToBuyerForUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :buyer, from: nil, to: false
  end
end
