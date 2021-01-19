class Mix < ApplicationRecord
  belongs_to :user
  has_many :mix_contents
  has_many :contents, through: :mix_contents
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :notes, :dependent => :destroy

  validates :title, presence: true

  accepts_nested_attributes_for :contents
  accepts_nested_attributes_for :notes, reject_if: proc {|attributes| attributes[:text].blank?}


end
