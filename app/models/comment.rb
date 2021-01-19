class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :mix
  has_rich_text :content
  validates :content, presence: true
  
end
