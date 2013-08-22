class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|

      t.string :type
      t.float :amount
      t.integer :customer_id
      t.timestamps
    end
  end
end
