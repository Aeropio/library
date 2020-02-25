class User < ApplicationRecord
  
  # config/locales/en.yml
# 1) If Mobile # exists in DB, show error message - Your already have Library card linked to your mobile number, please get a duplicate card from the library
# 2) If Email exists in DB, show error message - Your already have Library card linked to your email, please get a duplicate card from the library
# 3) If StateID exists in DB, show error message - Your already have Library card linked to your State ID, please get a duplicate card from the library
# 4) If First Name and DOB exists in DB, show error message - Your already have Library card issued on your name, please get a duplicate card from the library
# 5) If All checks pass, show a message - Application submitted successfully and trigger an EMAIL

  mount_uploader :identity_number, AvatarUploader
  mount_uploader :address_proof, PropertyUploader


  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #validates :first_name, :email, :phone_number, :home_address, :city, :zip, :dob, :last_name, :state, :primary_branch, :identity_number, presence: true
  validates :email, :phone_number, uniqueness: true
  # validates :email, format: {with: EMAIL_REGEX}
  # validates :phone_number,:numericality => true,
  #                         :length => { :minimum => 10, :maximum => 15 }
  validate :name_and_dob
  validate :validate_uniq_state_id_num
  validate :avatar_size_validation

  def name_and_dob
    first_names_arr = User.pluck(:first_name)
    dob_arr = User.pluck(:dob)
    if first_names_arr.include? first_name and dob_arr.include? dob
      errors.add(:first_name, "has already been taken")
    end
  end
  
  def validate_uniq_state_id_num
    id_card_arr = User.pluck(:state_id_card_number)
    if id_card_arr.include? state_id_card_number
      errors.add(:state_id_card_number, "has already been taken")
    end
  end

  def avatar_size_validation
    errors[:state_id_card_number] << " -- Maximum allowed size of file is 1MB" if identity_number.size > 1.megabytes
  end

  # def update_local_or_non_local_attributes
  #   zip_code = self.zip
  #   if zip_code.length==5 and zip_code.start_with?('282')
  #     self.is_local = true
  #   else
  #     self.is_local = false
  #   end 
  #   self.save(validate: false)
  # end
end
