require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid inputs" do
      it "sets the session variable to user_id" do
        user = Fabricate(:user)
        post :create, username: user.username, password: user.password
        expect(session[:user_id]).to eq user.id
      end
      it "redirects the user to the home page" do
        user = Fabricate(:user)
        post :create, username: user.username, password: user.password
        expect(response).to redirect_to home_path
      end
    end
    context "with invalid inputs" do
      it "redirects to landing page w params[:tab] set to log-in" do
        post :create
        expect(response).to redirect_to landing_path(tab: "log-in")
      end
    end
  end
end