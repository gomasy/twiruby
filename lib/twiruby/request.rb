require "erb"
require "net/https"

require "twiruby/utils"

module TwiRuby
  class Request
    attr_writer :user_agent

    METHODS = {
      "GET" => Net::HTTP::Get,
      "POST" => Net::HTTP::Post
    }

    def initialize(tokens, url)
      @tokens, @url = tokens, url

      @https = Net::HTTP.new(url.host, url.port)
      @https.use_ssl = true
      @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def create_request(method, path, body = nil, options = {})
      METHODS[method].new(path_with_options(path, options), {
        "Authorization" => Headers.new(@tokens, method, @url + path, body, options).to_s,
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

    def post(path, body = nil, options = {}, &blk)
      request(create_request("POST", path, body.to_q, options), body.to_q, &blk)
    end

    def path_with_options(path, options)
      !options.empty? ? %(#{path}?#{options.to_q}) : path
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
