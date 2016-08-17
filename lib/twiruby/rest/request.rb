require "json"
require "uri"

require "twiruby/request"

module TwiRuby
  module REST
    BASE_URL = URI.parse("https://api.twitter.com")

    class Request < TwiRuby::Request
      def initialize(tokens, url = BASE_URL)
        super
      end

      def request(req, body = nil, &blk)
        res = @https.request(req, body)
        res.code == "200" ? JSON.parse(res.body, symbolize_names: true) :
          fail(Error.type(res.code), Error.parse_error(res.body))
      end
    end
  end
end
