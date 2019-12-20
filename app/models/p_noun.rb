class PNoun < ApplicationRecord
  has_many :text_entries
  has_many :meta_tags, through: :p_noun_tags
end
