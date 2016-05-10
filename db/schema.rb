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

ActiveRecord::Schema.define(version: 20160510223326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.text     "definition"
    t.boolean  "module"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "language_id"
    t.integer  "parent_id"
  end

  add_index "klasses", ["language_id"], name: "index_klasses_on_language_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.decimal  "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
    t.integer  "klass_id"
  end

  add_index "languages", ["klass_id"], name: "index_languages_on_klass_id", using: :btree

  create_table "meths", force: :cascade do |t|
    t.string   "name"
    t.string   "signature"
    t.text     "description"
    t.text     "example"
    t.text     "source"
    t.boolean  "class_method"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "klasses", "languages"
  add_foreign_key "languages", "klasses"
end
