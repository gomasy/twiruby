require "net/https"
require "erb"
require "uri"

include ERB::Util

module TwiRuby
  class Request
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret
    attr_writer :user_agent

    def initialize(oauth)
      @oauth = oauth

      @https = Net::HTTP.new(OAuth::BASE_URL.host, OAuth::BASE_URL.port)
      @https.use_ssl = true
    end

    def request(req, body = nil)
      if !@oauth.has_consumer_token?
        @oauth.consumer_key = consumer_key
        @oauth.consumer_secret = consumer_secret
      end

      if !@oauth.has_oauth_token?
        @oauth.access_token = access_token
        @oauth.access_token_secret = access_token_secret
      end

      req["Authorization"] = @oauth.generate_header(req.method, "#{OAuth::BASE_URL}#{req.path}", body)
      req["User-Agent"] = user_agent

      @https.request(req, body)
    end

    def get(path, initheader = {})
      request(Net::HTTP::Get.new(path, initheader))
    end

    def post(path, data, initheader = {})
      if data != nil
        body = ""
        data.each do |s|
          body << "#{s[0]}=#{url_encode(s[1])}&"
        end
        body = body[0..body.length - 2]
      end

      request(Net::HTTP::Post.new(path, initheader), body)
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
