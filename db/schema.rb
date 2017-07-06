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

ActiveRecord::Schema.define(version: 20170706061547) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "category_dishes", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "dish_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "combo_dishes", force: :cascade do |t|
    t.integer  "combo_id"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combos", force: :cascade do |t|
    t.string   "description"
    t.integer  "discount"
    t.string   "name"
    t.string   "image"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "discount_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "image"
    t.string   "description"
    t.boolean  "is_available"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "humen", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "role"
    t.string   "phone_num"
    t.string   "password_digest"
    t.integer  "admin_role"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "order_combos", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "combo_id"
    t.integer  "discount"
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "total_price"
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "order_dishes", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "dish_id"
    t.integer  "discount"
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "total_price"
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "table_id"
    t.string   "code"
    t.date     "day"
    t.string   "time_in"
    t.boolean  "is_confirm", default: false
    t.integer  "discount",   default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer  "capacity"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
