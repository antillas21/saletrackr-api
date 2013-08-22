class CreatePurchaseItems < ActiveRecord::Migration
  def change
    create_table :purchase_items do |t|
      t.integer :qty, default: 1
      t.string :name
      t.integer :item_total, default: 0
      t.integer :purchase_id

      t.timestamps
    end

    add_index :purchase_items, :purchase_id
    add_index :purchase_items, :name
  end
end
