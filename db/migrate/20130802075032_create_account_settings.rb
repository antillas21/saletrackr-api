class CreateAccountSettings < ActiveRecord::Migration
  def change
    create_table :account_settings do |t|

      t.string :language, limit: 2
      t.string :store_name
      t.integer :user_id
      t.timestamps
    end

    add_index :account_settings, :user_id
  end
end
