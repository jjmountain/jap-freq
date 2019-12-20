class TextEntry < ApplicationRecord
  belongs_to :imported_text
  belongs_to :j_word, optional: true
  belongs_to :p_noun, optional: true
end
