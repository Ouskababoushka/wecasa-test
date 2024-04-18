class CreateOpeningHours < ActiveRecord::Migration[7.0]
  def change
    create_table :opening_hours do |t|
      t.references :professional, null: false, foreign_key: true
      t.integer :day
      t.time :open_at
      t.time :close_at

      t.timestamps
    end
  end
end
