class ImportedText < ApplicationRecord
  has_many :text_entries

  # returns an array of the associated proper nouns
  def p_nouns
    PNoun.joins(text_entries: [:imported_text]).where('imported_text_id = ?', id)
  end

  # returns a collection of j_words in the text for under the rank specified

  def j_words(rank = 152442)
    JWord.joins(text_entries: [:imported_text]).where('imported_text_id = ? AND cwj_rank <= ?', id, rank).uniq
  end

end
