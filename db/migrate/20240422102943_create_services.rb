class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :professional, null: false, foreign_key: true
      t.references :prestation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
