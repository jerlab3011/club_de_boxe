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

ActiveRecord::Schema.define(version: 20160826150710) do

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "address"
    t.string   "postal_code"
    t.date     "birth_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "gender"
    t.index ["user_id", "created_at"], name: "index_members_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "description"
    t.float    "price"
    t.integer  "duration"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.index ["member_id", "created_at"], name: "index_memberships_on_member_id_and_created_at"
    t.index ["member_id"], name: "index_memberships_on_member_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "created_by"
    t.string   "description"
    t.float    "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "postal_code"
    t.date     "birth_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.float    "total"
    t.string   "password_digest"
    t.string   "gender"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
