require "uri"

require "twiruby/oauth/utils"

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

      @req = Request.new(BASE_URL.host, BASE_URL.port)
    end

    def get_request_token
      @req.consumer_key = consumer_key
      @req.consumer_secret = consumer_secret

      response = @req.post(REQUEST_TOKEN_URL, nil).body
      token = Hash[URI::decode_www_form(response)]
      token["authorize_url"] = "#{BASE_URL}#{AUTHORIZE_URL}?#{response}"

      return token
    end

    def get_access_token(request_token, options = {})
      @req.access_token = request_token["oauth_token"]
      @req.access_token_secret = request_token["oauth_token_secret"]

      return Hash[URI::decode_www_form(@req.post(ACCESS_TOKEN_URL, options).body)]
    end
  end
end
