# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_09_180818) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["street", "city"], name: "index_addresses_on_street_and_city"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "size"
    t.integer "adaptation_for_seniors"
    t.integer "medical_equipment"
    t.integer "medicine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ubs", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "cnes_code"
    t.string "phone"
    t.integer "address_id"
    t.string "name"
    t.integer "score_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_ubs_on_address_id"
    t.index ["cnes_code"], name: "index_ubs_on_cnes_code", unique: true
    t.index ["latitude", "longitude"], name: "index_ubs_on_latiTude_and_longitude"
    t.index ["score_id"], name: "index_ubs_on_score_id"
  end

end
