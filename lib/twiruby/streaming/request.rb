require "json"
require "ostruct"
require "uri"

require "twiruby/request"

module TwiRuby
  module Streaming
    PUBLIC_BASE_URL = URI.parse("https://stream.twitter.com")
    USER_BASE_URL = URI.parse("https://userstream.twitter.com")
    SITE_BASE_URL = URI.parse("https://sitestream.twitter.com")

    class Request < TwiRuby::Request
      def get_response(req, body = nil, &blk)
        req["Accept-Encoding"] = "identity"

        @https.request(req) do |res|
          buffer = ""
          res.read_body do |chunk|
            next if chunk.empty? || chunk == "\r\n"

            buffer << chunk.chomp
            if chunk.end_with?("\r\n")
              begin
                blk.call(OpenStruct.new(JSON.parse(buffer, symbolize_names: true)))
              rescue JSON::ParserError
                # crush
              ensure
                buffer = ""
              end
            end
          end
        end
      end
    end
  end
end
