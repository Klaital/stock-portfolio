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

ActiveRecord::Schema.define(version: 20161027203846) do

  create_table "api_keys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "service"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "stock_positions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "symbol"
    t.integer  "qty"
    t.datetime "purchase_date"
    t.integer  "purchase_price"
    t.integer  "commission"
    t.integer  "current_price"
    t.datetime "last_updated"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "dataset"
    t.index ["user_id"], name: "index_stock_positions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "slug"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

end
