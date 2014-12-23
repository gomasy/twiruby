require "net/https"
require "erb"
require "uri"

include ERB::Util

module TwiRuby
  class Request < Net::HTTP
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret
    attr_writer :user_agent

    def initialize(address, port = nil)
      yield(self) if block_given?
      super
    end

    def request(req, body = nil)
      self.use_ssl = true

      oauth = OAuth.new do |config|
        config.consumer_key = consumer_key
        config.consumer_secret = consumer_secret
        config.access_token = access_token
        config.access_token_secret = access_token_secret
      end

      req["Authorization"] = oauth.generate_header(req.method, "https://#{self.address}#{req.path}", body)
      req["User-Agent"] = user_agent
      super
    end

    def get(path, initheader = {}, dest = nil)
      request(Get.new(path, initheader))
    end

    def post(path, data, initheader = {}, dest = nil)
      if data != nil
        body = ""
        data.each do |s|
          body << "#{s[0]}=#{url_encode(s[1])}&"
        end
        body = body[0..body.length - 2]
      end

      request(Post.new(path, initheader), body)
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
