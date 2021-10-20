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

ActiveRecord::Schema.define(version: 2021_10_20_012217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.text "purpose"
    t.text "cash_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "filer_id", null: false
    t.bigint "receiver_id", null: false
    t.index ["filer_id"], name: "index_awards_on_filer_id"
    t.index ["receiver_id"], name: "index_awards_on_receiver_id"
  end

  create_table "filers", force: :cascade do |t|
    t.text "ein"
    t.text "name"
    t.text "address"
    t.text "city"
    t.text "state"
    t.text "zip_code"
    t.bigint "award_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_id"], name: "index_filers_on_award_id"
  end

  create_table "receivers", force: :cascade do |t|
    t.text "ein"
    t.text "name"
    t.text "address"
    t.text "city"
    t.text "state"
    t.text "zip_code"
    t.bigint "award_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_id"], name: "index_receivers_on_award_id"
  end

  add_foreign_key "awards", "filers"
  add_foreign_key "awards", "receivers"
  add_foreign_key "filers", "awards"
  add_foreign_key "receivers", "awards"
end
