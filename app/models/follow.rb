class Follow < ActiveRecord::Base
  belongs_to :followee, class_name: 'User'
  belongs_to :follower, class_name: 'User'
  validates_uniqueness_of :follower, scope: :followee
end