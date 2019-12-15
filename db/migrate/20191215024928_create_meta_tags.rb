class CreateMetaTags < ActiveRecord::Migration[6.0]
  def change
    create_table :meta_tags do |t|
      t.string :tag
      t.string :meaning

      t.timestamps
    end
  end
end
