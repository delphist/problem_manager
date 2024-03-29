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

ActiveRecord::Schema.define(version: 20140112214458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "problem_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["problem_id"], name: "index_comments_on_problem_id", using: :btree

  create_table "problems", force: true do |t|
    t.integer  "subject_id"
    t.string   "person"
    t.text     "address"
    t.float    "address_longitude"
    t.float    "address_latitude"
    t.text     "description"
    t.string   "link"
    t.integer  "status_id"
    t.integer  "rating"
    t.string   "phone"
    t.string   "email"
    t.string   "vk"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "distance"
    t.float    "distance_car"
    t.text     "title"
  end

  add_index "problems", ["status_id"], name: "index_problems_on_status_id", using: :btree
  add_index "problems", ["subject_id"], name: "index_problems_on_subject_id", using: :btree

  create_table "statuses", force: true do |t|
    t.string   "title"
    t.string   "map_color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "tasks", force: true do |t|
    t.integer  "director_id",                       null: false
    t.integer  "executor_id",                       null: false
    t.integer  "problem_id"
    t.string   "title"
    t.text     "description"
    t.boolean  "completed",         default: false, null: false
    t.boolean  "completed_request", default: false, null: false
    t.datetime "completed_at"
    t.date     "deadline_at",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "access_level"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
