class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
