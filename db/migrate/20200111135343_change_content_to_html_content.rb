class ChangeContentToHtmlContent < ActiveRecord::Migration[6.0]
  def change
    rename_column :imported_texts, :content, :html_content
  end
end
