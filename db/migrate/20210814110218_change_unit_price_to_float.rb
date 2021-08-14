class ChangeUnitPriceToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :stocks, :unit_price, :float
    change_column :orders, :unit_price, :float
  end
end
