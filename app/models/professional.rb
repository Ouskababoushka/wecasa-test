class Professional < ApplicationRecord
  has_many :appointments
  has_many :services
  has_many :prestations, through: :services
  has_many :opening_hours, dependent: :destroy
end
