class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :spaces, foreign_key: "owner_id"
  has_many :bookings, through: :spaces

  has_many :reservations, class_name: "Booking"
end
