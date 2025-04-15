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

ActiveRecord::Schema[7.1].define(version: 2025_03_11_110118) do
  create_table "cards", id: false, force: :cascade do |t|
    t.integer "card_id", null: false
    t.string "name", null: false
    t.string "card_type", null: false
    t.string "frameType", null: false
    t.string "desc", null: false
    t.integer "atk"
    t.integer "def"
    t.string "race"
    t.string "card_attribute"
    t.integer "scale"
    t.integer "linkval"
    t.string "linkmarkers"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
