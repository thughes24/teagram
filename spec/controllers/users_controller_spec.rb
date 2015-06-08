require "spec_helper"

describe UsersController do
  describe "POST create" do
    context "With valid input" do
      it "should create user in database" do
        post :create, user: {username: "demo", email: "demo@example.com", password: "password"}
        expect(User.count).to eq(1)
      end
      it "should set session variable to user_id" do
        post :create, user: {username: "demo", email: "demo@example.com", password: "password"}
        expect(session[:user_id]).to eq(User.first.id)
      end
      it "should redirect to home path" do
        post :create, user: {username: "demo", email: "demo@example.com", password: "password"}
        expect(response).to redirect_to home_path
      end
    end
    context "With invalid input" do
      it "should set params[:tab] to sign-up" do
        post :create, user: {username: "poo"}
        expect(assigns(:for_test_purposes)).to eq "sign-up"
      end
      it "should render landing template" do
        post :create, user: {username: "fart-face"}
        expect(response).to render_template 'pages/index'
      end
    end
  end

  describe "GET show" do
    it "assigns the @user variable to current_user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end