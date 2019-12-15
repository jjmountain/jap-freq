class CreateEntryTags < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_tags do |t|
      t.references :j_word, null: false, foreign_key: true
      t.references :meta_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
