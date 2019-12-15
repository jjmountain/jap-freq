class CreateJWords < ActiveRecord::Migration[6.0]
  def change
    create_table :j_words do |t|
      t.string :entry
      t.text :english, array: true, default: []
      t.integer :cwj_rank
      t.text :tags, array: true, default: []

      t.timestamps
    end
  end
end
