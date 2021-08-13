class RemoveBuyerFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :buyer, :boolean
  end
end
