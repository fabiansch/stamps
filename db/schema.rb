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

ActiveRecord::Schema.define(version: 20180221004421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.integer "number"
    t.integer "postal_code"
    t.string "state"
    t.string "city"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_addresses_on_company_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "stamps_count"
    t.string "name"
    t.string "description"
    t.boolean "exploited"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_cards_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stampings", force: :cascade do |t|
    t.integer "count"
    t.bigint "card_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vendor_id", null: false
    t.bigint "address_id", null: false
    t.index ["address_id"], name: "index_stampings_on_address_id"
    t.index ["card_id"], name: "index_stampings_on_card_id"
    t.index ["user_id"], name: "index_stampings_on_user_id"
    t.index ["vendor_id"], name: "index_stampings_on_vendor_id"
  end

  create_table "stamps", force: :cascade do |t|
    t.bigint "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "stamping_id", null: false
    t.index ["card_id"], name: "index_stamps_on_card_id"
    t.index ["stamping_id"], name: "index_stamps_on_stamping_id"
    t.index ["user_id"], name: "index_stamps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email", default: "", null: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_vendors_on_company_id"
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "addresses", "companies"
  add_foreign_key "cards", "companies"
  add_foreign_key "stampings", "addresses"
  add_foreign_key "stampings", "cards"
  add_foreign_key "stampings", "users"
  add_foreign_key "stampings", "vendors"
  add_foreign_key "stamps", "cards"
  add_foreign_key "stamps", "stampings"
  add_foreign_key "stamps", "users"
  add_foreign_key "vendors", "companies"
  add_foreign_key "vendors", "users"
end
