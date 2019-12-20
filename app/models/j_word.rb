class JWord < ApplicationRecord
  has_many :entry_tags, dependent: :destroy
  has_many :meta_tags, through: :entry_tags
  has_many :text_entries
end
