class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :driver_license
      t.string :library_card_id
      t.string :home_address
      t.string :unit_number
      t.string :city
      t.string :zip
      t.string :phone_number

      t.timestamps
    end
  end
end
