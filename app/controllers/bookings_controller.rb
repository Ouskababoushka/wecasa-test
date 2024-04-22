class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @booking.user = User.first
    @prestations = Prestation.all
    @prestation = Prestation.find_by(id: params["booking"]["prestation_id"])
    @professionals = @prestation.professionals if @prestation

    closest_professional = find_closest_professional(@booking.lat, @booking.lng)

    if closest_professional.nil?
      flash[:alert] = 'No available professionals within range.'
      render 'home/confirmation' and return
    end

    @booking.professional = closest_professional

    if @booking.save
      redirect_to confirmation_path, notice: 'Booking was successfully created.'
    else
      render 'home/index', alert: 'Booking was NOT created.'
    end
  end

  def find_pro_for_existing_booking
    booking_id = params[:booking][:booking_id]
    booking = Booking.find(booking_id)

    closest_professional = find_closest_professional(booking.lat, booking.lng)
    booking.professional = closest_professional
    booking.save

    redirect_to confirmation_path, notice: 'Professional assigned successfully.'
  end

  def confirmation
  end

  private

  def booking_params
    params.require(:booking).permit(:prestation_id, :address_of_prestation, :lat, :lng)
  end

  def find_closest_professional(booking_lat, booking_lng)
    professionals = Professional.all
    nearest = professionals.min_by do |professional|
      distance = Geocoder::Calculations.distance_between([professional.latitude, professional.longitude],
                                                         [booking_lat, booking_lng], units: :km)
      distance if distance <= professional.max_kil
    end
    nearest
  end
end
