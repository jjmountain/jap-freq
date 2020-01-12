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

ActiveRecord::Schema.define(version: 2020_01_11_135343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "imported_texts", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "missing_words", default: [], array: true
    t.text "furigana_hash"
    t.text "html_content"
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
    t.bigint "j_word_id"
    t.bigint "p_noun_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "start_position", null: false
    t.integer "end_position", null: false
    t.boolean "found_by_kanji"
    t.index ["imported_text_id"], name: "index_text_entries_on_imported_text_id"
    t.index ["j_word_id"], name: "index_text_entries_on_j_word_id"
    t.index ["p_noun_id"], name: "index_text_entries_on_p_noun_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "j_word_tags", "j_words"
  add_foreign_key "j_word_tags", "meta_tags"
  add_foreign_key "p_noun_tags", "meta_tags"
  add_foreign_key "p_noun_tags", "p_nouns"
  add_foreign_key "text_entries", "imported_texts"
  add_foreign_key "text_entries", "j_words"
  add_foreign_key "text_entries", "p_nouns"
end
