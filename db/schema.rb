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

ActiveRecord::Schema.define(version: 20170315021945) do

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "phone",          limit: 8
    t.integer  "phone_alt",      limit: 8
    t.string   "website"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "street_address"
    t.string   "city",                     default: "St. Charles"
    t.string   "state",                    default: "IL"
    t.integer  "zip",            limit: 4
    t.string   "business_name"
    t.boolean  "partner",                  default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["business_name"], name: "index_contacts_on_business_name"
    t.index ["email"], name: "index_contacts_on_email", unique: true
    t.index ["first_name"], name: "index_contacts_on_first_name"
    t.index ["last_name"], name: "index_contacts_on_last_name"
  end

end
