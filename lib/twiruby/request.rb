require "net/https"
require "erb"
require "uri"

include ERB::Util

module TwiRuby
  BASE_URL = URI("https://api.twitter.com")

  class Request < Net::HTTP
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret
    attr_writer :user_agent

    def initialize(address, port = nil)
      yield(self)
      super
    end

    def request(req, body = nil, &block)
      oauth = OAuth.new do |config|
        config.consumer_key = consumer_key
        config.consumer_secret = consumer_secret
        config.access_token = access_token
        config.access_token_secret = access_token_secret
      end
      req["Authorization"] = oauth.generate_header(req.method, "#{TwiRuby::BASE_URL}#{req.path}", body)
      req["User-Agent"] = user_agent
      self.use_ssl = true
      super
    end

    def post(path, data, initheader = {}, dest = nil, &block)
      body = ""
      if data != nil
        data.each do |s|
          body << "#{s[0]}=#{url_encode(s[1])}&"
        end
        body = body[0..body.length - 2]
      end

      send_entity(path, body, initheader, dest, Post, &block)
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
