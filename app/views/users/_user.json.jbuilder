json.extract! user, :id, :email, :first_name, :last_name, :middle_name, :driver_license, :library_card_id, :home_address, :unit_number, :city, :zip, :phone_number, :created_at, :updated_at
json.url user_url(user, format: :json)
