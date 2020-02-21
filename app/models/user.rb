class User < ApplicationRecord
  
  # config/locales/en.yml
# 1) If Mobile # exists in DB, show error message - Your already have Library card linked to your mobile number, please get a duplicate card from the library
# 2) If Email exists in DB, show error message - Your already have Library card linked to your email, please get a duplicate card from the library
# 3) If StateID exists in DB, show error message - Your already have Library card linked to your State ID, please get a duplicate card from the library
# 4) If First Name and DOB exists in DB, show error message - Your already have Library card issued on your name, please get a duplicate card from the library
# 5) If All checks pass, show a message - Application submitted successfully and trigger an EMAIL



  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, :email, :phone_number, :home_address, :city, :zip, presence: true
  validates :email, :phone_number, uniqueness: true
  validates :email, format: {with: EMAIL_REGEX}
  validate :name_and_dob

  def name_and_dob
     #First Name and DOB exists in DB
  end
end
