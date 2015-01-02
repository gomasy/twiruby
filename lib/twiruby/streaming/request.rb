require "twiruby/request"

module TwiRuby
  module Streaming
    class Request < TwiRuby::Request
      def create_request(method, path, body = nil, options = {})
        METHODS[method].new((!options.empty? ? "#{path}?#{to_query(options)}" : path), {
          "Accept-Encoding" => "identity",
          "Authorization" => @oauth.generate_header(method, @url + path, body, options),
          "User-Agent" => user_agent
        })
      end

      def request(method, path, body = nil, options = {}, &blk)
        @https.request(create_request(method, path, body, options)) do |res|
          buffer = ""
          res.read_body do |chunk|
            next if chunk == "" || chunk == "\r\n"

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
