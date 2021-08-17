class RemoveIndexFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_index :orders, column: [:name], name: 'index_orders_on_name'
  end
end
