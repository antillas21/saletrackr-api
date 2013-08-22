class AddUniqueIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :uid, :integer
  end
end
