class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :unit_price
      t.integer :shares

      t.timestamps
    end
  end
end
