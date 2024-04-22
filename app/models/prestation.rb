class Prestation < ApplicationRecord
  has_many :services
  has_many :professionals, through: :services
  belongs_to :bookings, optional: true
end
