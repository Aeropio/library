class AddLibraryCardTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :library_card_type, :string
  end
end
