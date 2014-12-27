require "twiruby/oauth/utils"
require "uri"

module TwiRuby
  class OAuth
    include OAuth::Utils
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret, :base_url

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

      get_response(Request.new(self), "/oauth/request_token") do |res|
        token = Hash[URI::decode_www_form(res.body)]
        token["authorize_url"] = "#{base_url}/oauth/authorize?#{res.body}"

        return token
      end
    end

    def get_access_token(request_token, options = nil)
      @access_token = request_token["oauth_token"]
      @access_token_secret = request_token["oauth_token_secret"]

      get_response(Request.new(self), "/oauth/access_token", options) do |res|
        return Hash[URI::decode_www_form(res.body)]
      end
    end

    def get_response(req, path, options = nil)
      response = req.post(path, options)

      if response.code.to_i == 200
        yield(response) if block_given?
      elsif response.body.include?("<?xml")
        fail(Error.type(response.code.to_i), Error.parse_xml(response.body)[1])
      else
        fail(Error.type(response.code.to_i), response.body)
      end
    end

    def base_url
      @base_url ||= URI("https://api.twitter.com")
    end

    def has_consumer_token?
      !!(consumer_key != nil && consumer_secret != nil)
    end

    def has_oauth_token?
      !!(access_token != nil && access_token_secret != nil)
    end
  end
end
