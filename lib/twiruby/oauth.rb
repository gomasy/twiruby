require "uri"

require "twiruby/rest/request"

module TwiRuby
  class OAuth < TwiRuby::Client
    def get_request_token
      res = REST::Request.new(tokens).post("/oauth/request_token")
      token = Hash[URI::decode_www_form(res.body)]
      token["authorize_url"] = "#{REST::BASE_URL}/oauth/authorize?#{res.body}"

      token
    end

    def get_access_token(request_token, options = {})
      @access_token = request_token["oauth_token"]
      @access_token_secret = request_token["oauth_token_secret"]

      res = REST::Request.new(tokens).post("/oauth/access_token", options)
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
