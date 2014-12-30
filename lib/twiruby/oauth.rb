require "twiruby/oauth/utils"
require "uri"

module TwiRuby
  class OAuth
    include OAuth::Utils
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

    BASE_URL = URI("https://api.twitter.com")

    def initialize(options = {})
      @consumer_key = nil
      @consumer_secret = nil
      @access_token = nil
      @access_token_secret = nil

      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    def get_request_token
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret

      res = Request.new(self).post("/oauth/request_token")
      token = Hash[URI::decode_www_form(res.body)]
      token["authorize_url"] = "#{BASE_URL}/oauth/authorize?#{res.body}"

      token
    end

    def get_access_token(request_token, options = nil)
      @access_token = request_token["oauth_token"]
      @access_token_secret = request_token["oauth_token_secret"]

      res = Request.new(self).post("/oauth/access_token", options)
      Hash[URI::decode_www_form(res.body)]
    end

    def has_consumer_token?
      !!(consumer_key != nil && consumer_secret != nil)
    end

    def has_oauth_token?
      !!(access_token != nil && access_token_secret != nil)
    end
  end
end
