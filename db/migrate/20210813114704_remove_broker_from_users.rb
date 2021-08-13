class RemoveBrokerFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :broker, :boolean
  end
end
