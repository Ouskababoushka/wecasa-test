class CreateProfessionnals < ActiveRecord::Migration[7.0]
  def change
    create_table :professionnals do |t|
      t.string :name
      t.string :address
      t.float :lattitude
      t.float :longitude
      t.integer :max_kil

      t.timestamps
    end
  end
end
