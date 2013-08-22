class SetNewDefaults < ActiveRecord::Migration
  def up
    change_column_default(:customers, :balance, 0.0)
    change_column_default(:line_items, :item_total, nil)
    change_column_default(:transactions, :amount, 0.0)
    change_column(:line_items, :item_total, :float)
  end

  def down
    change_column_default(:customers, :balance, nil)
    change_column_default(:line_items, :item_total, 0)
    change_column_default(:transactions, :amount, nil)
    change_column(:line_items, :item_total, :integer)
  end
end
