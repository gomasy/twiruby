require "uri"

require "twiruby/client"
require "twiruby/rest/request"

module TwiRuby
  class OAuth < TwiRuby::Client
    # Allows a Consumer application to obtain an OAuth Request Token to request user authorization.
    #
    # @see https://dev.twitter.com/oauth/reference/post/oauth/request_token
    # @param options [Hash]
    def get_request_token(options = {})
      res = Request.new(tokens, REST::BASE_URL).post("/oauth/request_token", nil, options)
      token = Hash[URI::decode_www_form(res.body)]
      token["authorize_url"] = "#{REST::BASE_URL}/oauth/authorize?#{res.body}"

      token
    end

    # Allows a Consumer application to exchange the OAuth Request Token for an OAuth Access Token.
    #
    # @see https://dev.twitter.com/oauth/reference/post/oauth/access_token
    # @param request_token [Hash]
    # @param options [Hash]
    def get_access_token(request_token, options = {})
      @access_token = request_token["oauth_token"]
      @access_token_secret = request_token["oauth_token_secret"]

      res = Request.new(tokens, REST::BASE_URL).post("/oauth/access_token", nil, options)
      Hash[URI::decode_www_form(res.body)]
    end
  end
end
