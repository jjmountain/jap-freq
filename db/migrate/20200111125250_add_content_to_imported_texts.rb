class AddContentToImportedTexts < ActiveRecord::Migration[6.0]
  def change
    add_column :imported_texts, :content, :text
  end
end
