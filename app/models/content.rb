class Content < ApplicationRecord
  has_many :mix_contents
  has_many :notes, :dependent => :destroy
  has_many :mixes, through: :mix_contents

  accepts_nested_attributes_for :notes

  
  def specific_notes(mix)
    self.notes.where(mix_id: mix.id)
  end

  def self.search_by_q(q)
    by_title = all.select{|c|c.title.downcase.include?(q.downcase)}
    by_artist = all.select{|c|(c.creators & (c.creators.select{|cr|cr.downcase.include?(q.downcase)})).present?}
    (by_title + by_artist).uniq
  end
end
