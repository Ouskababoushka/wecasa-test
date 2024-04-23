class HomeController < ApplicationController
  before_action :set_prestations, only: [:index]
  before_action :set_existing_bookings, only: [:index]

  def index
  end

  def set_prestations
    @prestations = Prestation.all
  end

  def set_existing_bookings
    @existing_bookings = Booking.where(professional_id: nil).pluck(:id)
  end
end
