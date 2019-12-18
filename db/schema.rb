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

ActiveRecord::Schema.define(version: 2019_12_17_095137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "imported_texts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "j_word_tags", force: :cascade do |t|
    t.bigint "j_word_id", null: false
    t.bigint "meta_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["j_word_id"], name: "index_j_word_tags_on_j_word_id"
    t.index ["meta_tag_id"], name: "index_j_word_tags_on_meta_tag_id"
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

  create_table "p_noun_tags", force: :cascade do |t|
    t.bigint "p_noun_id", null: false
    t.bigint "meta_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meta_tag_id"], name: "index_p_noun_tags_on_meta_tag_id"
    t.index ["p_noun_id"], name: "index_p_noun_tags_on_p_noun_id"
  end

  create_table "p_nouns", force: :cascade do |t|
    t.string "entry"
    t.string "reading"
    t.text "english", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "text_entries", force: :cascade do |t|
    t.bigint "imported_text_id", null: false
    t.bigint "j_word_id", null: false
    t.bigint "p_noun_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imported_text_id"], name: "index_text_entries_on_imported_text_id"
    t.index ["j_word_id"], name: "index_text_entries_on_j_word_id"
    t.index ["p_noun_id"], name: "index_text_entries_on_p_noun_id"
  end

  add_foreign_key "j_word_tags", "j_words"
  add_foreign_key "j_word_tags", "meta_tags"
  add_foreign_key "p_noun_tags", "meta_tags"
  add_foreign_key "p_noun_tags", "p_nouns"
  add_foreign_key "text_entries", "imported_texts"
  add_foreign_key "text_entries", "j_words"
  add_foreign_key "text_entries", "p_nouns"
end
