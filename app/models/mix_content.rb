class MixContent < ApplicationRecord
  belongs_to :mix 
  belongs_to :content

  default_scope {order(created_at: :asc)}


end
