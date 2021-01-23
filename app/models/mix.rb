class Mix < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  has_many :mix_contents
  has_many :contents, through: :mix_contents
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :notes, :dependent => :destroy
 
  validates :title, presence: true, length: {in: 1..30}

  accepts_nested_attributes_for :contents
  accepts_nested_attributes_for :notes, reject_if: proc {|attributes| attributes[:text].blank?}

  scope :most_recent, -> {all.order(updated_at: :desc)}
  scope :sort_by_recent, ->(ids) {most_recent.where(id: ids)}

  def last_updated
    updated_at.strftime("%A, %b %d")
  end

  def self.get_by_query(q)
    by_title = all.select{|m|m.title.downcase.include?(q.downcase)}
    content = Content.search_by_q(q)
    by_content = all.select{|m|(m.contents & content).present?}
    (by_title + by_content).uniq
  end

  def sort_contents_by_recent
    # contents.sort_by{|c|c.mix_contents.collect{|mc|mc.updated_at}}.reverse
    contents.sort_by{|c|c.mix_contents.select{|mc|mc.mix == self}.sort_by{|mc|mc.created_at}}
  end
end
