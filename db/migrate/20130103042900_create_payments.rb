class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :payment_date
      t.integer :amount
      t.integer :customer_id

      t.timestamps
    end

    add_index :payments, :payment_date
    add_index :payments, :customer_id
  end
end
