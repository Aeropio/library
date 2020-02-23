class AddPrimaryBranchToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :primary_branch, :string
  end
end
