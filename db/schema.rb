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

ActiveRecord::Schema.define(version: 20141204141551) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "date_of_event"
    t.string   "image"
    t.string   "external_link"
    t.integer  "total_price"
    t.text     "description"
    t.integer  "max_users"
    t.integer  "min_users"
    t.boolean  "paid",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
  end

  create_table "payments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "role",           default: "user"
    t.boolean  "payment_status", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "venmo_id"
    t.string   "venmo_encrypted_token"
    t.string   "email"
    t.string   "twitter_id"
    t.string   "twitter_handle"
    t.string   "twitter_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

end
