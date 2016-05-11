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

ActiveRecord::Schema.define(version: 20160511043154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text     "text"
    t.integer  "components_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "components_type"
  end

  add_index "articles", ["components_id"], name: "index_articles_on_components_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "documents", ["language_id"], name: "index_documents_on_language_id", using: :btree

  create_table "includes", force: :cascade do |t|
    t.integer  "includer_id"
    t.integer  "includee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.text     "definition"
    t.boolean  "module"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "language_id"
    t.integer  "parent_id"
    t.integer  "namespace_id"
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
    t.integer  "klass_id"
  end

  add_index "meths", ["klass_id"], name: "index_meths_on_klass_id", using: :btree

  add_foreign_key "documents", "languages"
  add_foreign_key "klasses", "languages"
  add_foreign_key "languages", "klasses"
  add_foreign_key "meths", "klasses"
end
