class FollowsController < ApplicationController
  def create
    @follow = Follow.new(followee_id: params[:format] ,follower_id: current_user.id)
    if @follow.save
      redirect_to :back
    else
      @follow = Follow.find_by(followee_id: params[:format] ,follower_id: current_user.id)
      @follow.destroy
      redirect_to :back
    end
  end
end