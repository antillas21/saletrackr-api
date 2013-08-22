class AddFieldsToLineItems < ActiveRecord::Migration
  def change
    rename_table 'purchase_items', 'line_items'

    add_column :line_items, :color, :string
    add_column :line_items, :size, :string
    add_column :line_items, :cost, :float
    add_column :line_items, :price, :float
  end
end
