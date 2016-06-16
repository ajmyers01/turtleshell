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

ActiveRecord::Schema.define(version: 20160615235713) do

  create_table "recipients", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "recipients", ["user_id"], name: "index_recipients_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.boolean  "completed",       limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "completion_date"
    t.integer  "priority",        limit: 4
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "email",           limit: 255
    t.string "password_digest", limit: 255
    t.string "first_name",      limit: 255
    t.string "last_name",       limit: 255
  end

end
