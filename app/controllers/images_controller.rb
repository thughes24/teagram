class ImagesController < ApplicationController
  before_action :logged_in_only
  def index
    @title = "News Feed"
    @images = Image.all
    @comment = Comment.new
  end

  def explore
    @title = "Explore all Images"
    @images = Image.all
    @comment = Comment.new
  end

  def new
    @image = Image.new(key: params[:key])
  end

  def create
    @image = Image.new(image_params)
    @image.user = current_user
    if @image.save
      @image.add_tags_from_caption
      redirect_to home_path
    else
      render :upload_2
    end
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @title = @image.shorten_caption
  end

  def search
    @title = "Search Results: ##{params[:search]}"
    @images = Image.search_by_hashtag(params[:search])
  end

  def upload_1
    @title = "Upload Image"
    @uploader = Image.new.image
    @uploader.success_action_redirect = new_image_url
  end

  private
  def image_params
    params.require(:image).permit!
  end
end