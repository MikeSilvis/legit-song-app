require 'open-uri'
class Upload < ActiveRecord::Base
  attr_accessible :url, :artist, :title

  def self.upload_to_s3(file, title, artist)
	   upload = Upload.new(title: title, artist: artist)
     FileUploader.store("#{artist}-#{title}", add_meta_data(file), CURRENT_BUCKET, access: :public_read)
     upload.url = "http://#{CURRENT_BUCKET}.s3.amazonaws.com/#{artist}-#{title}"
     upload.save
  end

  def self.add_meta_data(file_url)
  	file = open("http://ec-media.soundcloud.com/7mbrzwW0QvaH.128.mp3?ff61182e3c2ecefa438cd02102d0e385713f0c1faf3b0339595667fb0d0ded1d4001494890461e840ba2a7cfbabdcdaab9719c7655dd543c85aee62b59b443f8c507831559&AWSAccessKeyId=AKIAJBHW5FB4ERKUQUOQ&Expires=1341286936&Signature=YTeyoG%2FRhkPnCehdwubGP1UcpwA%3D")
		Mp3Info.open(file.path) do |mp3|
		   mp3.tag.title = "track title"
		   mp3.tag.artist = "artist name"
		end
		file
  end

end
