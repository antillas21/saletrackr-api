class AddCostToPurchases < ActiveRecord::Migration
  def change
    add_column :transactions, :cost, :float, default: 0.0
  end
end
