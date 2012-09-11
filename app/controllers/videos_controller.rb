class VideosController < ApplicationController
  def index
    @videos = Video.find_all_by_user_id(current_user.id)
  end

  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264.hi"]
    @webm_encoding = @original_video.encodings["webm"]
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create!(params[:video])
    #redirect_to :action => :show, :id => @video.id
    redirect_to videos_path
  end

  def destroy
    Video.find(params[:id]).destroy
    flash[:success] = "Film zostal usuniety"
    redirect_to videos_path
  end

end
