class JWord < ApplicationRecord
  has_many :j_word_tags, dependent: :destroy
  has_many :meta_tags, through: :j_word_tags
  has_many :text_entries
end
