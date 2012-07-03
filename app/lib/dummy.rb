require 'faraday'
require 'awesome_print'
class Awesome

  def self.fetch(uri_str, limit = 10)
    Faraday.get "http://hypem.com/serve/play/1n8bs/e5c78fae6292e1ce00ebf16244b5a603" do |req|
      req.headers["Cookie"] = "AUTH=03%3Aad986f5e59838895cd867706aad40c13%3A1341336508%3A1117341873%3ADC-US"
    end
  end

end

ap Awesome.fetch('http://www.ruby-lang.org').headers["location"]