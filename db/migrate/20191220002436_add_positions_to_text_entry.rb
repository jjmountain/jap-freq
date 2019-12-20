class AddPositionsToTextEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :text_entries, :start_position, :integer, null: false
    add_column :text_entries, :end_position, :integer, null: false
  end
end
