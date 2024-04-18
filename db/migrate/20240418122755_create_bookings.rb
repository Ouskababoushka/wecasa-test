class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prestation, null: false, foreign_key: true
      t.string :address_of_prestation
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
