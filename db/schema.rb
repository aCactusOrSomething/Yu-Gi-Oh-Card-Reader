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

ActiveRecord::Schema[7.1].define(version: 2025_05_30_212327) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_data", force: :cascade do |t|
    t.decimal "database_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer "card_id"
    t.string "name"
    t.string "card_type"
    t.string "frameType"
    t.string "desc"
    t.integer "atk"
    t.integer "def"
    t.string "race"
    t.string "card_attribute"
    t.integer "scale"
    t.integer "linkval"
    t.string "linkmarkers"
    t.integer "level"
    t.string "name_searchable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_cards_on_card_id", unique: true
  end

end
