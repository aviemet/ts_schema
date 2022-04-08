# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_08_205725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "examples", force: :cascade do |t|
    t.string "col_string", null: false
    t.text "col_text", null: false
    t.integer "col_integer", null: false
    t.integer "col_enum", null: false
    t.bigint "col_bigint", null: false
    t.float "col_float", null: false
    t.decimal "col_decimal", null: false
    t.json "col_json"
    t.jsonb "col_jsonb"
    t.binary "col_binary"
    t.boolean "col_boolean"
    t.date "col_date"
    t.datetime "col_datetime"
    t.datetime "col_timestamp", precision: nil
    t.inet "col_inet"
    t.cidr "col_cidr"
    t.macaddr "col_macaddr"
  end

  create_table "examples_fives", id: false, force: :cascade do |t|
    t.bigint "example_id"
    t.bigint "part_id"
    t.index ["example_id"], name: "index_examples_fives_on_example_id"
    t.index ["part_id"], name: "index_examples_fives_on_part_id"
  end

  create_table "fives", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fours", force: :cascade do |t|
    t.bigint "example_id", null: false
    t.bigint "three_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["example_id"], name: "index_fours_on_example_id"
    t.index ["three_id"], name: "index_fours_on_three_id"
  end

  create_table "ones", force: :cascade do |t|
    t.bigint "example_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["example_id"], name: "index_ones_on_example_id"
  end

  create_table "overrides", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "omit"
    t.string "deep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "threes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "twos", force: :cascade do |t|
    t.bigint "example_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["example_id"], name: "index_twos_on_example_id"
  end

  add_foreign_key "fours", "examples"
  add_foreign_key "fours", "threes"
  add_foreign_key "ones", "examples"
  add_foreign_key "twos", "examples"
end
