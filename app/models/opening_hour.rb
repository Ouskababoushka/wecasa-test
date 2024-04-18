class OpeningHour < ApplicationRecord
  belongs_to :professional
  
  validates :day, presence: true
  validates :open_at, presence: true
  validates :close_at, presence: true
end
