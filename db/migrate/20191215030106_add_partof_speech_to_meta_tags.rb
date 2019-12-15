class AddPartofSpeechToMetaTags < ActiveRecord::Migration[6.0]
  def change
    add_column :meta_tags, :part_of_speech, :boolean
  end
end
