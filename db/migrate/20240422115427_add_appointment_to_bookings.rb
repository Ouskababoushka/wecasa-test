class AddAppointmentToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :appointment, null: false, foreign_key: true
  end
end
