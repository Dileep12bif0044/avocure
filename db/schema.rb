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

ActiveRecord::Schema.define(version: 20171028032803) do

  create_table "employee_employee_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "employee_type_id"
    t.bigint "employee_id"
    t.datetime "created_at", default: "2017-11-03 06:07:35", null: false
    t.datetime "updated_at", default: "2017-11-03 06:07:35", null: false
    t.index ["employee_id"], name: "index_employee_employee_types_on_employee_id"
    t.index ["employee_type_id"], name: "index_employee_employee_types_on_employee_type_id"
  end

  create_table "employee_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "work_type", null: false
    t.datetime "created_at", default: "2017-11-03 06:07:34", null: false
    t.datetime "updated_at", default: "2017-11-03 06:07:34", null: false
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", null: false
    t.string "name"
    t.string "password", null: false
    t.string "auth_token"
    t.string "time_stamp"
    t.datetime "created_at", default: "2017-11-03 06:07:35", null: false
    t.datetime "updated_at", default: "2017-11-03 06:07:35", null: false
  end

  add_foreign_key "employee_employee_types", "employee_types"
  add_foreign_key "employee_employee_types", "employees"
end
