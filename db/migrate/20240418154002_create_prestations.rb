class CreatePrestations < ActiveRecord::Migration[7.0]
  def change
    create_table :prestations do |t|
      t.string :reference
      t.integer :duration

      t.timestamps
    end
  end
end
