class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.image_id = params[:image_id]
    if @comment.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end 