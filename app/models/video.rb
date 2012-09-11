class Video < ActiveRecord::Base
  attr_accessible :title, :user_id, :panda_video_id
  
  belongs_to :user
  
  validates_presence_of :panda_video_id

  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end
  
end
