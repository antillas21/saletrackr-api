class RemoveCallbackCalculatedColumnsFromModels < ActiveRecord::Migration
  def up
    remove_column :customers, :balance
    remove_column :purchases, :purchase_total
  end

  def down
    add_column :customers, :balance, :integer, default: 0
    add_column :purchases, :purchase_total, :integer, default: 0
  end
end
