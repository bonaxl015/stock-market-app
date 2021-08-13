class AddDefaultValueTrueToAdminForUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :admin, from: nil, to: true
  end
end
