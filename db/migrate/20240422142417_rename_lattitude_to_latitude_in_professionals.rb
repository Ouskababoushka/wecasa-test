class RenameLattitudeToLatitudeInProfessionals < ActiveRecord::Migration[7.0]
  def change
    rename_column :professionals, :lattitude, :latitude
  end
end
