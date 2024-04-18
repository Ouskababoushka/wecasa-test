class RenameProfessional < ActiveRecord::Migration[7.0]
  def change
    rename_table :professionnals, :professionals
  end
end
