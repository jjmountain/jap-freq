class ImportedText < ApplicationRecord
  has_many :text_entries, dependent: :destroy
  has_one_attached :cover_photo
  serialize :furigana_hash


  # returns an array of the associated proper nouns
  def p_nouns
    PNoun.joins(text_entries: [:imported_text]).where('imported_text_id = ?', id)
  end

  # returns a collection of j_words in the text for under the rank specified

  def j_words
    JWord.joins(text_entries: [:imported_text]).where('imported_text_id = ?', id).uniq
  end

end
