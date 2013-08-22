class AddUidToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :uid, :integer
  end
end
