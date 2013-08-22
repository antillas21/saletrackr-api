class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.date :purchase_date
      t.integer :purchase_total, default: 0
      t.integer :customer_id

      t.timestamps
    end

    add_index :purchases, :purchase_date
    add_index :purchases, :purchase_total
    add_index :purchases, :customer_id
  end
end
