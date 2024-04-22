class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :prestation
  belongs_to :professional, optional: true
end
