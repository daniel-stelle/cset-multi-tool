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

ActiveRecord::Schema.define(version: 20160210025444) do

  create_table "roles", force: :cascade do |t|
    t.boolean  "tech",       default: false
    t.boolean  "checkout",   default: false
    t.boolean  "ta_grader",  default: false
    t.boolean  "supervisor", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id"

  create_table "timesheet_rows", force: :cascade do |t|
    t.integer  "timesheet_id"
    t.date     "date_worked"
    t.datetime "time_in"
    t.datetime "time_out"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "timesheet_rows", ["timesheet_id"], name: "index_timesheet_rows_on_timesheet_id"

  create_table "timesheets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "timesheets", ["user_id"], name: "index_timesheets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.integer  "role_id"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
