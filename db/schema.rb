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

ActiveRecord::Schema.define(version: 2020_04_11_214737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenge_ingredients", force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "ingredient_id"
    t.index ["challenge_id"], name: "index_challenge_ingredients_on_challenge_id"
    t.index ["ingredient_id"], name: "index_challenge_ingredients_on_ingredient_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.integer "time_limit"
    t.integer "basket_size"
    t.integer "meal_type", default: 0
    t.integer "game_status", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "google_token"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
  end

  add_foreign_key "challenge_ingredients", "challenges"
  add_foreign_key "challenge_ingredients", "ingredients"
  add_foreign_key "challenges", "users"
  add_foreign_key "ingredients", "users"
end
