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

      begin
        response = @req.post(REQUEST_TOKEN_URL, nil)

        if response.body.include?("oauth_token")
          token = Hash[URI::decode_www_form(response.body)]
          token["authorize_url"] = "#{BASE_URL}#{AUTHORIZE_URL}?#{response.body}"

          return token
        else
          fail(Error.raise(response.code), response.body)
        end
      end
    end

    def get_access_token(request_token, options = {})
      @req.access_token = request_token["oauth_token"]
      @req.access_token_secret = request_token["oauth_token_secret"]

      begin
        response = @req.post(ACCESS_TOKEN_URL, options)

        if response.body.include?("oauth_token")
          return Hash[URI::decode_www_form(response.body)]
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
