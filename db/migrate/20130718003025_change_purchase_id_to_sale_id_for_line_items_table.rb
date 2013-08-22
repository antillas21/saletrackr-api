class ChangePurchaseIdToSaleIdForLineItemsTable < ActiveRecord::Migration
  def change
    rename_column :line_items, :purchase_id, :sale_id
  end
end
