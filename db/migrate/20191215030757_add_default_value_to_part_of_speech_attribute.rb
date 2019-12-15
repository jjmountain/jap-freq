class AddDefaultValueToPartOfSpeechAttribute < ActiveRecord::Migration[6.0]
  def change
    change_column :meta_tags, :part_of_speech, :boolean, default: false
  end
end
