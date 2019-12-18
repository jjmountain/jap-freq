class CreateImportedTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :imported_texts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
