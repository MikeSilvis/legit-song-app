require 'open-uri'
class UploadersController < ApplicationController

  def show
    @files = Upload.all
  end

  def create
    params[:tracks].each do |track|
      Thread.new do
        track  = track[1]
        file   = "http://hypem.com/serve/play/#{track['id']}/#{track['key']}"
        upload = Upload.upload_to_s3(file, track["song"], track["artist"], track["id"], track["thumb_url_large"])
      end
    end
    render json: "MIKE YOUR AWESOME", status: :created
  end

end