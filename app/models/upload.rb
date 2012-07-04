require 'open-uri'

class Upload < ActiveRecord::Base
  attr_accessible :url, :artist, :title, :song_id, :artwork
  validates_uniqueness_of :song_id
  AUTH = "03%3Aa93d72140f864529e3c350aaf5231bf2%3A1334250701%3A1144071075%3ADC-US"

  def catch_redirect(uri_str)
    resp = Faraday.get uri_str do |req|
            req.headers["Cookie"] = "AUTH=#{AUTH}"
           end
    resp.headers["location"]
  end

  def self.upload_to_s3(file, title, artist, song_id, artwork)
     file_name = "#{artist}-#{title}.mp3"
	   upload = Upload.new(title: title, artist: artist, song_id: song_id, url: "http://#{CURRENT_BUCKET}.s3.amazonaws.com/#{file_name}", artwork: artwork)
     upload.add_meta_data(file,title, artist)
     FileUploader.store("#{file_name}", upload.add_meta_data(file, title, artist), CURRENT_BUCKET, access: :public_read) if upload.save
  end

  def add_meta_data(file_url, title, artist)
    begin
    	file = open(catch_redirect(file_url))
  		Mp3Info.open(file.path) do |mp3|
  		   mp3.tag.title  = title
  		   mp3.tag.artist = artist
  		end
    rescue
      puts "shit... #{title} - #{artist}"
    end
      file
  end

end
