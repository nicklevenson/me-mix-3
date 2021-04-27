class User < ApplicationRecord

  has_many :mixes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_many :follow_relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :follow_relationships, source: :followed

  has_one_attached :avatar
  has_secure_password

  validates :username, presence: true, length: {in: 1..30}
  validates :email, presence: true, uniqueness: true
  validates :password, length: {in: 7..32}, :if => :password_digest_changed?



  def self.create_from_omniauth(auth)
    self.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.image = auth['info']['image']
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
      u.password_confirmation = u.password
    end
  end

  def follow(other_user)
    follow_relationships.create(follower_id: self.id, followed_id: other_user.id)
  end

  def followed_by
    User.all.select{|user| user.followed_users.include?(self)}
  end

  def following_mixes
    Mix.where(user: followed_users)
  end

  def self.sort_by_followers
    all.sort_by{|u| u.followed_by.count}.reverse
  end

  def feed 
    Mix.where(user: followed_users).or(Mix.where(user: self)).order(updated_at: :desc)
  end
  
  def not_followed_yet
    User.all.select{|user| !user.followed_by.include?(self) && user != self}.sort_by{|u|u.mixes.length}.reverse()[0..8]
  end

  def liked_mixes
    Mix.where(likes: self.likes)
  end

  def commented_mixes
    Mix.where(comments: self.comments)
  end

  def my_image 
    if avatar.attached?
      avatar
    else
      image
    end
  end
end
