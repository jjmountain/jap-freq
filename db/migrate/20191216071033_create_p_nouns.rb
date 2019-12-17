class CreatePNouns < ActiveRecord::Migration[6.0]
  def change
    create_table :p_nouns do |t|
      t.string :entry
      t.string :reading
      t.text :english

      t.timestamps
    end
  end
end
