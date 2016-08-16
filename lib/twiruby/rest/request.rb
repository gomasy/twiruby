require "json"
require "uri"

require "active_support"
require "active_support/core_ext"

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
        if res.code == "200"
          obj = JSON.parse(res.body)

          case obj
          when Array
            obj.map! do |x| x.with_indifferent_access end
          when Hash
            obj = obj.with_indifferent_access
          end
        else
          fail(Error.type(res.code), Error.parse_error(res.body))
        end
      end
    end
  end
end
