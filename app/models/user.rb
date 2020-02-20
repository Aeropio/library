class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  #Name, DOB, Phone, ID or Email exist in Database
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, :email, :phone_number, :home_address, :city, :zip, presence: true
  validates :email, :phone_number, :first_name, uniqueness: true
  validates :email, format: {with: EMAIL_REGEX}
end
