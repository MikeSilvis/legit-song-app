require 'net/http'
require 'uri'

class Awesome

  def self.fetch(uri_str, limit = 10)
    # You should choose better exception.
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0
    url = URI.parse(uri_str)
    req = Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then fetch(response['location'], limit - 1)
    else
      response.error!
    end
  end

end

print Awesome.fetch('http://www.ruby-lang.org')