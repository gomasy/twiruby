require "twiruby/request"

module TwiRuby
  module Streaming
    class Request < TwiRuby::Request
      def create_request(method, path, body = nil, options = {})
        full_path = !options.empty? ? "#{path}?#{to_query(options)}" : path
        METHODS[method].new(full_path, {
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

            if !chunk.end_with?("\r\n")
              buffer << chunk
            else
              buffer << chunk

              blk.call(buffer)
              buffer = ""
            end
          end
        end
      end
    end
  end
end
