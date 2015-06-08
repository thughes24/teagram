class LikesController < ApplicationController
  before_action :logged_in_only
  def create
    @like = Like.new(image_id: params[:id], user: current_user)
    if @like.save
      redirect_to :back
    else
      Like.find_by(user_id: current_user.id, image_id: params[:id]).delete
      redirect_to :back
    end
  end
end