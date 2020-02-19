class AddIdentityNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :identity_number, :string
  end
end
