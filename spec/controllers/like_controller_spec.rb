require 'spec_helper'

describe LikesController do
  describe "POST create" do
    it "likes image if the user has not already liked it" do
      user = Fabricate(:user)
      sally = Fabricate(:user)
      session[:user_id] = user.id
      image = Fabricate(:image, user: sally)
      request.env["HTTP_REFERER"] = '/home'
      post :create, id: image.id
      expect(Image.first.likes.count).to eq(1)
    end
    it "unlikes the image if the user has already liked it" do
      user = Fabricate(:user)
      sally = Fabricate(:user)
      session[:user_id] = user.id
      image = Fabricate(:image, user: sally)
      Like.create(user_id: user.id, image_id: image.id)
      request.env["HTTP_REFERER"] = '/home'
      post :create, id: image.id
      expect(Image.first.likes.count).to eq(0)
    end
  end
end