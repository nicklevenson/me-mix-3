class User < ApplicationRecord

  has_many :mixes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_many :following, foreign_key: :follower_id, class_name: :FollowRelationship
  has_many :followers, foreign_key: :followed_id, class_name: :FollowRelationship

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

  def followed_users
    User.includes(:following, :avatar_attachment).where(id: following.map{|fr|fr.followed_id})
  end

  def followed_by
    User.includes(:followers, :avatar_attachment).where(id: followers.map{|fr|fr.follower_id})
    # User.all.select{|user| user.followed_users.include?(self)}
  end

  def following_mixes
    Mix.includes({:contents => :notes}, {:comments => :user}, :user).where(user: followed_users)
  end

  def self.sort_by_followers
    all.sort_by{|u| u.followed_by.count}.reverse
  end

  def feed 
    Mix.includes(:rich_text_description, :contents, {:comments => [:user, :rich_text_content]}, {:user => :avatar_attachment}).where(user: followed_users).or(Mix.where(user: self)).order(updated_at: :desc)
  end
  
  def not_followed_yet
    User.includes(:following, :followers, :avatar_attachment).where.not(id: self.followed_users.ids.push(self.id))
    # User.all.select{|user| !user.followed_by.include?(self) && user != self}.sort_by{|u|u.mixes.length}.reverse()[0..8]
  end

  def liked_mixes
    Mix.includes(:rich_text_description, :contents, {:comments => [:user, :rich_text_content]}, {:user => [:avatar_attachment]}).where(likes: self.likes)
  end

  def commented_mixes
    Mix.includes(:rich_text_description, :contents, {:comments => [:user, :rich_text_content]}, {:user => [:avatar_attachment]}).where(comments: self.comments)
  end

  def my_image 
    if avatar.attached?
      avatar
    else
      image
    end
  end
end
