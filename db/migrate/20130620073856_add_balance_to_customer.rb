class AddBalanceToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :balance, :float
  end
end
