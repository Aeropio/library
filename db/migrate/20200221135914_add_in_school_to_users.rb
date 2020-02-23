class AddInSchoolToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :in_school, :boolean, :default => false
  end
end
