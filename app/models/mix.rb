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

  scope :most_recent, -> {all.order(updated_at: :desc)}
  scope :sort_by_recent, ->(ids) {most_recent.where(id: ids)}
end
