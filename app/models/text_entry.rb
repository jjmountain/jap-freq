class TextEntry < ApplicationRecord
  belongs_to :imported_text
  belongs_to :j_word
  belongs_to :p_noun
end
