class RemoveAppointmentFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bookings, :appointment, index: true, foreign_key: true
    add_reference :bookings, :professional, index: true, foreign_key: true, null: true
  end
end
