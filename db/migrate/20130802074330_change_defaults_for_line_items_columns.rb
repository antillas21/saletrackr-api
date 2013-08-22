class ChangeDefaultsForLineItemsColumns < ActiveRecord::Migration
  def change
    change_column_default :line_items, :cost, 0
    change_column_default :line_items, :price, 0
  end
end
