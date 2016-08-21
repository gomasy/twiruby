require "erb"
require "net/http"
require "net/http/post/multipart"

require "twiruby/utils"

module TwiRuby
  class Request
    attr_writer :user_agent

    def initialize(tokens, url)
      @tokens, @url = tokens, url

      @https = Net::HTTP.new(url.host, url.port)
      @https.use_ssl = true
      @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def create_request(request, path, file = nil, options = {})
      if file.nil?
        request.new(path_with_options(path, options))
      else
        request.new(path_with_options(path, options), file)
      end
    end

    def request(request, path, body = nil, file = nil, options = {}, &blk)
      req = create_request(request, path, file, options)
      req["Authorization"] = Headers.new(@tokens, req.method, @url + path, body, options).to_s
      req["User-Agent"] = user_agent

      get_response(req, body, &blk)
    end

    def get_response(req, body = nil, &blk)
      res = @https.request(req, body)
      res.code == "200" ? res : fail(Error.type(res.code), Error.parse_error(res.body))
    end

    def get(path, options = {}, &blk)
      request(Net::HTTP::Get, path, nil, nil, options, &blk)
    end

    def post(path, body = nil, options = {}, &blk)
      request(Net::HTTP::Post, path, body.to_q, nil, options, &blk)
    end

    def multipart_post(path, file = nil, options = {}, &blk)
      request(Net::HTTP::Post::Multipart, path, nil, file, options, &blk)
    end

    def path_with_options(path, options)
      !options.empty? ? %(#{path}?#{options.to_q}) : path
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
