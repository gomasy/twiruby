require "twiruby/oauth/utils"
require "uri"

module TwiRuby
  class OAuth
    include OAuth::Utils

    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

    BASE_URL = URI("https://api.twitter.com")
    REQUEST_TOKEN_URL = "/oauth/request_token"
    ACCESS_TOKEN_URL = "/oauth/access_token"
    AUTHORIZE_URL = "/oauth/authorize"

    def initialize
      yield(self) if block_given?

      @req = Request.new(BASE_URL.host, BASE_URL.port) do |config|
        config.consumer_key = consumer_key
        config.consumer_secret = consumer_secret
      end
    end

    def get_request_token
      if !has_consumer_token?
        @req.consumer_key = consumer_key
        @req.consumer_secret = consumer_secret
      end

      get_response("/oauth/request_token") do |res|
        token = Hash[URI::decode_www_form(res.body)]
        token["authorize_url"] = "#{BASE_URL}/oauth/authorize?#{res.body}"

        return token
      end
    end

    def get_access_token(request_token, options = nil)
      @req.access_token = request_token["oauth_token"]
      @req.access_token_secret = request_token["oauth_token_secret"]

      get_response("/oauth/access_token", options) do |res|
        return Hash[URI::decode_www_form(res.body)]
      end
    end

    def get_response(path, options = nil)
      begin
        response = @req.post(path, options)

        if response.body.include?("oauth_token")
          yield(response) if block_given?
        elsif response.body.include?("<?xml")
          require "rexml/document"
          xml = REXML::Document.new(response.body)

          fail(Error.raise(response.code), xml.elements["/hash/error"].text)
        else
          fail(Error.raise(response.code), response.body)
        end
      end
    end

    def has_consumer_token?
      !(consumer_key != "" && consumer_secret != "")
    end

    def has_oauth_token?
      !(access_token != "" && access_token_secret != "")
    end
  end
end
