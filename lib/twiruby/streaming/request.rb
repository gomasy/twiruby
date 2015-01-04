require "twiruby/request"

module TwiRuby
  module Streaming
    class Request < TwiRuby::Request
      def request(req, body = nil, options = {}, &blk)
        req["Accept-Encoding"] = "identity"

        @https.request(req) do |res|
          buffer = ""
          res.read_body do |chunk|
            next if chunk.empty? || chunk == "\r\n"

            buffer << chunk
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
