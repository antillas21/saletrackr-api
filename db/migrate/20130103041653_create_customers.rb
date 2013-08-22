class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :balance, default: 0
      t.integer :user_id

      t.timestamps
    end

    add_index :customers, :user_id
    add_index :customers, :name
    add_index :customers, :balance
  end
end
