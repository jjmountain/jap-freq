class AddFuriganaHashToImportedTexts < ActiveRecord::Migration[6.0]
  def change
    add_column :imported_texts, :furigana_hash, :text
  end
end
