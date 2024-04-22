class AddStartsAtToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :starts_at, :datetime
  end
end
