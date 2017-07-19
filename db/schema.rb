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

ActiveRecord::Schema.define(version: 20170719181123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_notes", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_notes_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_contact_notes_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.bigint   "phone"
    t.bigint   "phone_alt"
    t.string   "website"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "street_address"
    t.string   "city",           default: "St. Charles"
    t.string   "state",          default: "IL"
    t.integer  "zip"
    t.string   "business_name"
    t.boolean  "partner",        default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["business_name"], name: "index_contacts_on_business_name", using: :btree
    t.index ["email"], name: "index_contacts_on_email", unique: true, using: :btree
    t.index ["first_name"], name: "index_contacts_on_first_name", using: :btree
    t.index ["last_name"], name: "index_contacts_on_last_name", using: :btree
  end

  create_table "contacts_groups", id: false, force: :cascade do |t|
    t.integer "group_id",   null: false
    t.integer "contact_id", null: false
    t.index ["contact_id", "group_id"], name: "index_contacts_groups_on_contact_id_and_group_id", using: :btree
    t.index ["group_id", "contact_id"], name: "index_contacts_groups_on_group_id_and_contact_id", using: :btree
  end

  create_table "group_notes", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "group_id"
    t.index ["group_id"], name: "index_group_notes_on_group_id", using: :btree
    t.index ["user_id"], name: "index_group_notes_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_groups_on_name", unique: true, using: :btree
  end

  create_table "links", force: :cascade do |t|
    t.string   "title"
    t.string   "destination"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "group_id"
    t.index ["group_id"], name: "index_links_on_group_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
