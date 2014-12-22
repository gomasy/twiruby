require "net/https"
require "uri"

module TwiRuby
  BASE_URL = URI("https://api.twitter.com")

  class Request < Net::HTTP
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret
    attr_writer :user_agent

    def request(req, body = nil, &block)
      oauth = OAuth.new(consumer_key, consumer_secret, access_token, access_token_secret)
      req["Authorization"] = oauth.generate_header(req.method, "#{TwiRuby::BASE_URL}#{req.path}")
      req["User-Agent"] = user_agent
      self.use_ssl = true
      super
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
