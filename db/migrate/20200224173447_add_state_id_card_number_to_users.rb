class AddStateIdCardNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :state_id_card_number, :string
  end
end
