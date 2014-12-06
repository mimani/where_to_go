# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 8) do

  create_table "accounts", force: true do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.string "role"
  end

  create_table "attractions", force: true do |t|
    t.string "attraction"
    t.string "attraction_holiday_iq_id"
    t.string "type"
    t.string "display_name"
    t.string "city"
    t.string "rank"
  end

  create_table "cities", force: true do |t|
    t.string "city"
    t.string "city_holiday_iq_id"
    t.string "state"
  end

  create_table "city_attraction_mappings", force: true do |t|
    t.string "city_id"
    t.string "attraction_id"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

end
