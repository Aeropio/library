class AddCardStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :card_status, :string, :default => 'pending'
  end
end
