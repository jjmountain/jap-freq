class ChangePNounColumnToArray < ActiveRecord::Migration[6.0]
  def change
    change_column :p_nouns, :english, :text, array: true, default: [], using: "(string_to_array(english, ','))"
  end
end
