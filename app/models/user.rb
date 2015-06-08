class User < ActiveRecord::Base
  has_many :images
  has_many :comments
  has_many :likes
  has_many :follows, foreign_key: 'followee_id'
  has_many :followers, through: :follows
  has_many :inverse_follows, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :followees, through: :inverse_follows, source: :followee
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true
  validates :username, uniqueness: true

  def following?(user)
    followees.map(&:id).include?(user.id)
  end
end