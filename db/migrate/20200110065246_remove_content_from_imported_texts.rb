class RemoveContentFromImportedTexts < ActiveRecord::Migration[6.0]
  def change
    remove_column :imported_texts, :content
  end
end
