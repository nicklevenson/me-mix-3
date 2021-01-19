class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :mix
  has_rich_text :content
  validates :content, presence: true

  after_create_commit {broadcast_append_to "#{mix.id}comments", target: "#{mix.id}comments"}
  after_update_commit {broadcast_replace_to "#{mix.id}comments"}
  after_destroy_commit {broadcast_remove_to "#{mix.id}comments"}
  
end
