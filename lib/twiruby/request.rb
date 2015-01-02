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

    def initialize(oauth, url)
      @oauth = oauth
      @url = url

      @https = Net::HTTP.new(url.host, url.port)
      @https.use_ssl = true
      @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def create_request(method, path, body = nil, options = {})
      METHODS[method].new((!options.empty? ? "#{path}?#{to_query(options)}" : path), {
        "Authorization" => @oauth.generate_header(method, @url + path, body, options),
        "User-Agent" => user_agent
      })
    end

    def request(method, path, body = nil, options = {}, &blk)
      res = @https.request(create_request(method, path, body, options), body)
      res.code.to_i == 200 ? res : fail(Error.type(res.code.to_i), Error.parse_message(res))
    end

    def get(path, options = {}, &blk)
      request("GET", path, nil, options, &blk)
    end

    def post(path, data = nil, options = {}, &blk)
      request("POST", path, to_query(data), options, &blk)
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
