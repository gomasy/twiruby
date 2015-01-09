require "net/https"
require "erb"

require "twiruby/utils"

module TwiRuby
  class Request
    include TwiRuby::Utils
    attr_writer :user_agent

    METHODS = {
      "GET" => Net::HTTP::Get,
      "POST" => Net::HTTP::Post
    }

    def initialize(tokens, url)
      @tokens = tokens
      @url = url

      @https = Net::HTTP.new(url.host, url.port)
      @https.use_ssl = true
      @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def create_request(method, path, body = nil, options = {})
      METHODS[method].new((!options.empty? ? "#{path}?#{build_query(options)}" : path), {
        "Authorization" => Headers.generate_header(@tokens, method, @url + path, body, options),
        "User-Agent" => user_agent
      })
    end

    def request(req, body = nil, &blk)
      res = @https.request(req, body)
      res.code == "200" ? res : fail(Error.type(res.code), Error.parse_error(res.body))
    end

    def get(path, options = {}, &blk)
      request(create_request("GET", path, nil, options), nil, &blk)
    end

    def post(path, data = nil, options = {}, &blk)
      body = build_query(data)
      request(create_request("POST", path, body, options), body, &blk)
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
