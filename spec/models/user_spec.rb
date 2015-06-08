require 'spec_helper'

describe User do
  it {should have_many(:images)}
  it {should have_many(:comments)}
  it {should have_many(:likes)}
  it {should have_many(:follows)}
  it {should have_many(:followers).through(:follows)}

  describe "#following?" do
    it "should return true if current_user is following user page" do
      user = Fabricate(:user)
      bob = Fabricate(:user)
      Follow.create(follower: user, followee: bob)
      expect(user.following?(bob)).to be true
    end
    it "should return false if current_user is not following user page" do
      user = Fabricate(:user)
      bob = Fabricate(:user)
      Follow.create(follower: bob, followee: user)
      expect(user.following?(bob)).to be false  
    end   
  end
end