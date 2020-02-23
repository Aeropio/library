class AddIsPhysicalCardToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_physical_card, :boolean, :default => true
  end
end
