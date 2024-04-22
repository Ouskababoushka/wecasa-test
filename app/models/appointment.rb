class Appointment < ApplicationRecord
  belongs_to :professional
  has_one :booking
end
