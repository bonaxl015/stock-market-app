class AddIndexToStocks < ActiveRecord::Migration[6.0]
  def change
    add_index :stocks, :name, unique: true
  end
end
