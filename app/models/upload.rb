require 'open-uri'
class Upload < ActiveRecord::Base
  attr_accessible :url, :artist, :title
  AUTH = "03%3Aad986f5e59838895cd867706aad40c13%3A1341336508%3A1117341873%3ADC-US"

  def self.catch_redirect(uri_str)
    resp = Faraday.get uri_str do |req|
            req.headers["Cookie"] = "AUTH=#{AUTH}"
           end
    resp.headers["location"]
  end

  def self.upload_to_s3(file, title, artist)
	   upload = Upload.new(title: title, artist: artist)
     file_name = "#{artist}-#{title}.mp3"
     FileUploader.store("#{file_name}", add_meta_data(file, title, artist), CURRENT_BUCKET, access: :public_read)
     upload.url = "http://#{CURRENT_BUCKET}.s3.amazonaws.com/#{file_name}"
     upload.save
  end

  def self.add_meta_data(file_url, title, artist)
  	file = open(catch_redirect(file_url))
		Mp3Info.open(file.path) do |mp3|
		   mp3.tag.title  = title
		   mp3.tag.artist = artist
		end
		file
  end

end
