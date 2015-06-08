require 'spec_helper'

describe FollowsController do
  describe 'POST create' do
    it "sets the current_user to follow the selected user" do
      follower = Fabricate(:user)
      followee = Fabricate(:user)
      session[:user_id] = follower.id
      request.env["HTTP_REFERER"] = '/home'
      post :create, format: followee.id
      expect(followee.followers.count).to eq(1)
    end
    it "sets the current_user to unfollow the selected user if already following" do
      follower = Fabricate(:user)
      followee = Fabricate(:user)
      session[:user_id] = follower.id
      request.env["HTTP_REFERER"] = '/home'
      Follow.create(follower_id: follower.id, followee_id: followee.id)
      post :create, format: followee.id
      expect(followee.followers.count).to eq(0)
    end
    it "does not set the selected user to follow the current user" do
      follower = Fabricate(:user)
      followee = Fabricate(:user)
      session[:user_id] = follower.id
      request.env["HTTP_REFERER"] = '/home'
      post :create, id: followee.id
      expect(follower.followers.count).to eq(0)
    end
  end
end