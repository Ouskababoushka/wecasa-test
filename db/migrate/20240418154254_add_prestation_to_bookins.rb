class AddPrestationToBookins < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :prestation, null: false, foreign_key: true
  end
end
