require "twiruby/request"

module TwiRuby
  module Streaming
    class Request < TwiRuby::Request
      def create_request(method, path, body = nil, options = {})
        path = "#{path}?#{to_query(options)}" if !options.empty?
        METHODS[method].new(path, {
          "Accept-Encoding" => "identity",
          "Authorization" => @oauth.generate_header(method, "#{@url}#{path.gsub(/\?#{to_query(options)}/, "")}", body, options),
          "User-Agent" => user_agent
        })
      end

      def request(method, path, body = nil, options = {}, &blk)
        @https.request(create_request(method, path, body, options)) do |res|
          res.read_body do |chunk|
            blk.call(chunk)
          end
        end
      end
    end
  end
end
