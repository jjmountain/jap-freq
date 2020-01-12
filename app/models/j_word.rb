class JWord < ApplicationRecord
  has_many :meta_tags, through: :j_word_tags
  has_many :text_entries
end
