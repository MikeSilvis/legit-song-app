require 'open-uri'
class UploadersController < ApplicationController

  def show
    # @uploaded_files = Upload.where(user_token: @user_token, room_id: @room_id)
  end

  def create
    upload = Upload.upload_to_s3(params[:file], params[:title], params[:artist])
    redirect_to "/uploader"
  end

end
