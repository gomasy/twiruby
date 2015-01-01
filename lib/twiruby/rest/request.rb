require "uri"

require "twiruby/request"

module TwiRuby
  module REST
    BASE_URL = URI.parse("https://api.twitter.com")

    class Request < TwiRuby::Request
      def initialize(oauth, url = BASE_URL)
        super
      end
    end
  end
end
