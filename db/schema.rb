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

ActiveRecord::Schema.define(version: 20130802075032) do

  create_table "account_settings", force: true do |t|
    t.string   "language",   limit: 2
    t.string   "store_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_settings", ["user_id"], name: "index_account_settings_on_user_id"

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "balance",    default: 0.0
    t.integer  "uid"
  end

  add_index "customers", ["name"], name: "index_customers_on_name"
  add_index "customers", ["user_id"], name: "index_customers_on_user_id"

  create_table "line_items", force: true do |t|
    t.integer  "qty",             default: 1
    t.string   "name"
    t.float    "item_sale_total"
    t.integer  "sale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
    t.string   "size"
    t.float    "cost",            default: 0.0
    t.float    "price",           default: 0.0
    t.float    "item_cost_total"
  end

  add_index "line_items", ["name"], name: "index_line_items_on_name"
  add_index "line_items", ["sale_id"], name: "index_line_items_on_sale_id"

  create_table "transactions", force: true do |t|
    t.string   "type"
    t.float    "amount",      default: 0.0
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "cost",        default: 0.0
    t.integer  "uid"
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
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
