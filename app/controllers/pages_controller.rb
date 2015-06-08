class PagesController < ApplicationController
  before_action :logged_out_only
  def index
    @title = "Landing Page"
    @user = User.new
  end
end