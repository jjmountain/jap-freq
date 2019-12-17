class CreatePNounTags < ActiveRecord::Migration[6.0]
  def change
    create_table :p_noun_tags do |t|
      t.references :p_noun, null: false, foreign_key: true
      t.references :meta_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
