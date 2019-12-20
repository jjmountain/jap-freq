class AddMissingWordsToImportedTexts < ActiveRecord::Migration[6.0]
  def change
    add_column :imported_texts, :missing_words, :string, array: true, default: []
  end
end
