# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_26_124544) do

  create_table "availabilities", id: false, force: :cascade do |t|
    t.integer "amount", default: 0, null: false
    t.integer "department_id"
    t.integer "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_availabilities_on_department_id"
    t.index ["product_id"], name: "index_availabilities_on_product_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "city", null: false
    t.string "district"
    t.string "street", null: false
    t.decimal "profits", precision: 2, default: "0", null: false
    t.decimal "expenses", precision: 2, default: "0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_positions", id: false, force: :cascade do |t|
    t.integer "amount", null: false
    t.integer "order_id"
    t.integer "pizza_id"
    t.index ["order_id"], name: "index_order_positions_on_order_id"
    t.index ["pizza_id"], name: "index_order_positions_on_pizza_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "price", null: false
    t.integer "department_id"
    t.string "address"
    t.string "receive_form"
    t.string "status"
    t.string "additional_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_orders_on_department_id"
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "recipes", id: false, force: :cascade do |t|
    t.integer "amount", null: false
    t.integer "product_id"
    t.integer "pizza_id"
    t.index ["pizza_id"], name: "index_recipes_on_pizza_id"
    t.index ["product_id"], name: "index_recipes_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "position"
    t.integer "department_id"
    t.integer "salary"
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.boolean "active", default: false
    t.boolean "approved", default: false
    t.boolean "confirmed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["perishable_token"], name: "index_users_on_perishable_token", unique: true
    t.index ["persistence_token"], name: "index_users_on_persistence_token", unique: true
    t.index ["single_access_token"], name: "index_users_on_single_access_token", unique: true
  end

end
