require 'spec_helper'

describe CommentsController do
  describe "POST create" do
    it "posts to database with valid input" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      image = Fabricate(:image)
      request.env["HTTP_REFERER"] = '/home'
      post :create, comment: {body: "random text"}, image_id: image.id
      expect(Image.first.comments.count).to eq(1)
    end
  end
end