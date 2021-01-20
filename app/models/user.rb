class User < ApplicationRecord

  has_many :mixes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_many :follow_relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :follow_relationships, source: :followed

  has_one_attached :avatar
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 7}


  def self.create_from_omniauth(auth)
      self.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.image = auth['info']['image']
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
    end
  end
  def follow(other_user)
    follow_relationships.create(follower_id: self.id, followed_id: other_user.id)
  end

  def followed_by
    User.all.select{|user| user.followed_users.include?(self)}
  end

  def following_mixes
    # followed_users.collect{|u|u.mixes}
    mixes = Mix.where(user: followed_users)
    # byebug
  end

  def feed 
    (following_mixes + self.mixes)
  end
end
