class CreateTextEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :text_entries do |t|
      t.references :imported_text, null: false, foreign_key: true
      t.references :j_word, null: false, foreign_key: true
      t.references :p_noun, null: false, foreign_key: true

      t.timestamps
    end
  end
end
