class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.integer :unit_price
      t.integer :shares

      t.timestamps
    end
  end
end
