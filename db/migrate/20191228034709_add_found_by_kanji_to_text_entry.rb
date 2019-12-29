class AddFoundByKanjiToTextEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :text_entries, :found_by_kanji, :boolean
  end
end
