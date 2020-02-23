class AddHasPropertyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :has_property, :boolean, :default => false
  end
end
