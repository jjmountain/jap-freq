class AddReadingToJWords < ActiveRecord::Migration[6.0]
  def change
    add_column :j_words, :reading, :string
  end
end
