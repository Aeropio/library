class AddIsLocalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_local, :boolean
  end
end
