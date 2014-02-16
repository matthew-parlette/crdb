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

ActiveRecord::Schema.define(version: 20140215224033) do

  create_table "customers", force: true do |t|
    t.string   "title"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "importance",  default: 0
    t.boolean  "active",      default: true
    t.string   "links",       default: ""
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "due_date"
    t.date     "completed_date"
    t.string   "status"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "links",          default: ""
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id"

end
