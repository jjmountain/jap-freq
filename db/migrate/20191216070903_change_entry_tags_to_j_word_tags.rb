class ChangeEntryTagsToJWordTags < ActiveRecord::Migration[6.0]
  def change
    rename_table :entry_tags, :j_word_tags
  end
end
