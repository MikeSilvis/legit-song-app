require 'open-uri'
class Upload < ActiveRecord::Base
  attr_accessible :url, :artist, :title

  def self.upload_to_s3(file, title, artist)
	   upload = Upload.new(title: title, artist: artist)
     file_name = "#{artist}-#{title}"
     FileUploader.store("#{file_name}", add_meta_data(file, title, artist), CURRENT_BUCKET, access: :public_read)
     upload.url = "http://#{CURRENT_BUCKET}.s3.amazonaws.com/#{file_name}"
     upload.save
  end

  def self.add_meta_data(file_url, title, artist)
  	file = open(file_url)
		Mp3Info.open(file.path) do |mp3|
		   mp3.tag.title  = title
		   mp3.tag.artist = artist
		end
		file
  end

end
