require "uri"

require "twiruby/request"

module TwiRuby
  module Streaming
    PUBLIC_BASE_URL = URI.parse("https://stream.twitter.com")
    USER_BASE_URL = URI.parse("https://userstream.twitter.com")
    SITE_BASE_URL = URI.parse("https://sitestream.twitter.com")

    class Request < TwiRuby::Request
      def request(req, body = nil, options = {}, &blk)
        req["Accept-Encoding"] = "identity"

        @https.request(req) do |res|
          buffer = ""
          res.read_body do |chunk|
            next if chunk.empty? || chunk == "\r\n"

            buffer << chunk.chomp
            if chunk.end_with?("\r\n")
              blk.call(buffer)
              buffer = ""
            end
          end
        end
      end
    end
  end
end
