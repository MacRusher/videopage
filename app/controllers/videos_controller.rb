class VideosController < ApplicationController
  def index
    authenticate_user! rescue redirect_to new_user_session_path
    #@videos = Video.find_all_by_user_id(current_user.id)
    @videos = current_user.videos.all
  end

  def show
    authenticate_user! rescue redirect_to new_user_session_path
    
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264.hi"]
    @webm_encoding = @original_video.encodings["webm"]
  end
  
  def embed
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings["h264.hi"]
    @webm_encoding = @original_video.encodings["webm"]
    
    render :layout => 'embed'
  end

  def new
    authenticate_user! rescue redirect_to new_user_session_path
    
    @video = Video.new
  end

  def create
    authenticate_user! rescue redirect_to new_user_session_path
    
    @video = Video.create!(params[:video])
    #redirect_to :action => :show, :id => @video.id
    redirect_to videos_path
  end

  def destroy
    authenticate_user! rescue redirect_to new_user_session_path
    
    video = Video.find(params[:id])
    video.panda_video.delete
    video.destroy
    flash[:success] = "Film zostal usuniety"
    redirect_to videos_path
  end

end
