class AddCostTotalAndChangeItemTotalFieldsToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :item_cost_total, :float
    rename_column :line_items, :item_total, :item_sale_total
  end
end
