class Professional < ApplicationRecord
  has_many :services
  has_many :prestations, through: :services
  has_many :appointments, dependent: :destroy
  has_many :opening_hours, dependent: :destroy
end
