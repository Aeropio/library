class AddCountyNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :county_name, :string
  end
end
