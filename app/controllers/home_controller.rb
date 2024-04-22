class HomeController < ApplicationController
  def index
    @prestations = Prestation.all
    @existing_bookings = Booking.where(professional_id: nil).pluck(:id)
  end
end
