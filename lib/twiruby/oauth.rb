require "uri"

require "active_support"
require "active_support/core_ext"

require "twiruby/client"
require "twiruby/request"

module TwiRuby
  class OAuth < TwiRuby::Client
    def request
      Request.new(tokens, REST::BASE_URL)
    end

    # Allows a Consumer application to obtain an OAuth Request Token to request user authorization.
    #
    # @see https://dev.twitter.com/oauth/reference/post/oauth/request_token
    # @param options [Hash]
    def get_request_token(options = {})
      res = request.post("/oauth/request_token", nil, options)
      token = Hash[URI::decode_www_form(res.body)]
      token[:authorize_url] = "#{REST::BASE_URL}/oauth/authorize?#{res.body}"

      token.with_indifferent_access
    end

    # Allows a Consumer application to exchange the OAuth Request Token for an OAuth Access Token.
    #
    # @see https://dev.twitter.com/oauth/reference/post/oauth/access_token
    # @param request_token [Hash]
    # @param options [Hash]
    def get_access_token(request_token, options = {})
      @oauth_token = request_token[:oauth_token]
      @oauth_token_secret = request_token[:oauth_token_secret]

      res = request.post("/oauth/access_token", nil, options)
      tokens.update(Hash[URI::decode_www_form(res.body)]).with_indifferent_access
    end
  end
end
