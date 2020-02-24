class AddAddressProofToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address_proof, :string
  end
end
