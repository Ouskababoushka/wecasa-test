class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @booking.user = User.first
    @prestation = Prestation.find_by(id: params['booking']['prestation_id'])

    if @prestation.nil?
      flash[:alert] = 'Prestation not found.'
      redirect_to home_index_path and return
    end

    # Geocode the address
    if @booking.address_of_prestation.present?
      coordinates = Geocoder.coordinates(@booking.address_of_prestation)
      if coordinates
        @booking.lat, @booking.lng = coordinates
      else
        flash[:alert] = 'Geocoding failed, please check the address.'
        render 'home/index' and return
      end
    end

    @nearest_professionals = find_closest_professionals(@booking.lat, @booking.lng) if @booking.lat && @booking.lng

    if @booking.save
      redirect_to confirmation_path(nearest_professionals: @nearest_professionals || [])
    else
      flash[:alert] = 'Booking was NOT created.'
      render 'home/index'
    end
  end

  def find_pro_for_existing_booking
    booking_id = params[:booking][:booking_id]
    booking = Booking.find(booking_id)
    @prestation = booking.prestation

    @nearest_professionals = find_closest_professionals(booking.lat, booking.lng)

    redirect_to confirmation_path(nearest_professionals: @nearest_professionals)
  end

  def confirmation
    if params[:nearest_professionals].blank?
      @selected_professionals = nil
      flash[:notice] = 'No nearest professionals found.'
    else
      @selected_professionals = Professional.where(id: params[:nearest_professionals])
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:prestation_id, :address_of_prestation, :lat, :lng)
  end

  def find_closest_professionals(booking_lat, booking_lng)
    return [] unless @prestation

    professionals = @prestation.professionals.select do |professional|
      distance = Geocoder::Calculations.distance_between([professional.latitude, professional.longitude],
                                                         [booking_lat, booking_lng], units: :km)
      distance <= professional.max_kil  # Only select professionals within range
    end

    professionals.map(&:id)
  end
end
