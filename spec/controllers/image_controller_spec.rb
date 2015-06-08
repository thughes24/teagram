require 'spec_helper'

describe ImagesController do
  describe "GET index" do
    it "redirects to landing page if user is logged out" do
      get :index
      expect(response).to redirect_to landing_path
    end
    it "assigns @images variable to array of all image objects" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      image1 = Fabricate(:image)
      image2 = Fabricate(:image)
      get :index
      expect(assigns(:images)).to match_array([image1,image2])
    end 
  end

  describe "GET search" do
    it "redirects to landing page if user is logged out" do
      get :search
      expect(response).to redirect_to landing_path
    end
    it "assigns @images to search result" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      image1 = Fabricate(:image, caption: "hello #hi")
      get :search, search: "hi"
      expect(assigns(:images)).to match_array([image1])
    end
  end

  describe "GET show" do
    it "assigns the @image variable by parmams id" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      image = Fabricate(:image)
      get :show, id: image.id
      expect(assigns(:image)).to eq(image)
    end

    it "sets the title to the users name + Image" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      image = Fabricate(:image, user: user, caption: "this will be shortened here")
      get :show, id: image.id
      expect(assigns(:title)).to eq("This will be shortened...")      
    end
    it "redirects if logged out" do
      session[:user_id] = nil
      image = Fabricate(:image)
      get :show, id: image.id
      expect(response).to redirect_to landing_path
    end
  end
end