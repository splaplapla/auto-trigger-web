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

ActiveRecord::Schema[7.0].define(version: 2023_04_08_141659) do
  create_table "command_rules", force: :cascade do |t|
    t.string "condition_key", null: false
    t.string "condition_name", null: false
    t.integer "procon_bypass_man_command_id"
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "procon_bypass_man_commands", force: :cascade do |t|
    t.string "name", null: false
    t.string "first_buttons", null: false
    t.string "second_buttons"
    t.integer "repeat_count", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "procon_bypass_man_hosts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "port", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer "procon_bypass_man_host_id"
    t.string "capture_device_name"
    t.boolean "capture_enabled", default: false, null: false
    t.string "unique_key", default: "setting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unique_key"], name: "index_settings_on_unique_key", unique: true
  end

end
