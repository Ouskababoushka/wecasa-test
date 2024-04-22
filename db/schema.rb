# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_22_142417) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.bigint "professional_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id"], name: "index_appointments_on_professional_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address_of_prestation"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "prestation_id", null: false
    t.bigint "professional_id"
    t.datetime "starts_at"
    t.index ["prestation_id"], name: "index_bookings_on_prestation_id"
    t.index ["professional_id"], name: "index_bookings_on_professional_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "opening_hours", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.integer "day"
    t.time "open_at"
    t.time "close_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id"], name: "index_opening_hours_on_professional_id"
  end

  create_table "prestations", force: :cascade do |t|
    t.string "reference"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professionals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "max_kil"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.bigint "professional_id", null: false
    t.bigint "prestation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prestation_id"], name: "index_services_on_prestation_id"
    t.index ["professional_id"], name: "index_services_on_professional_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "professionals"
  add_foreign_key "bookings", "prestations"
  add_foreign_key "bookings", "professionals"
  add_foreign_key "bookings", "users"
  add_foreign_key "opening_hours", "professionals"
  add_foreign_key "services", "prestations"
  add_foreign_key "services", "professionals"
end
