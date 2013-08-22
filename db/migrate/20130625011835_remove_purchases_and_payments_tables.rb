class RemovePurchasesAndPaymentsTables < ActiveRecord::Migration
  def up
    drop_table :payments
    drop_table :purchases
  end

  def down
    create_table :purchases do |t|
      t.date     :purchase_date
      t.integer  :customer_id
      t.datetime :created_at,    :nil => false
      t.datetime :updated_at,    :nil => false
    end

    create_table :payments do |t|
      t.date     :payment_date
      t.integer  :amount
      t.integer  :customer_id
      t.datetime :created_at,   :nil => false
      t.datetime :updated_at,   :nil => false
    end
  end
end
