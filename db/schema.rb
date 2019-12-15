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

ActiveRecord::Schema.define(version: 2019_12_15_032842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entry_tags", force: :cascade do |t|
    t.bigint "j_word_id", null: false
    t.bigint "meta_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["j_word_id"], name: "index_entry_tags_on_j_word_id"
    t.index ["meta_tag_id"], name: "index_entry_tags_on_meta_tag_id"
  end

  create_table "j_words", force: :cascade do |t|
    t.string "entry"
    t.text "english", default: [], array: true
    t.integer "cwj_rank"
    t.text "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reading"
  end

  create_table "meta_tags", force: :cascade do |t|
    t.string "tag"
    t.string "meaning"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "part_of_speech", default: false
  end

  add_foreign_key "entry_tags", "j_words"
  add_foreign_key "entry_tags", "meta_tags"
end
