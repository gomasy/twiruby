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

      @req = Request.new(self)
    end

    def get_request_token
      @req.consumer_key = consumer_key
      @req.consumer_secret = consumer_secret

      get_response("/oauth/request_token") do |res|
        token = Hash[URI::decode_www_form(res.body)]
        token["authorize_url"] = "#{base_url}/oauth/authorize?#{res.body}"

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

        if response.code == "200"
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
