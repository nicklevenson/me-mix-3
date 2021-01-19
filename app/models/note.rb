class Note < ApplicationRecord
  belongs_to :mix
  belongs_to :content
  has_rich_text :text
end
