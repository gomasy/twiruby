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

    def create_request(request, path, file = {}, options = {})
      file.empty? ? request.new(path_with_options(path, options)) :
        request.new(path_with_options(path, options), file)
    end

    def request(request, path, body = {}, file = {}, options = {}, &blk)
      req = create_request(request, path, file, options)
      req["Authorization"] = Headers.new(@tokens, req.method, @url + path, options.update(body)).to_s
      req["User-Agent"] = user_agent

      get_response(req, body.to_q, &blk)
    end

    def get_response(req, body = nil, &blk)
      res = @https.request(req, body)
      res.code =~ /20\d/ ? res : fail(Error.type(res.code), Error.parse_error(res.body))
    end

    def get(path, options = {}, &blk)
      request(Net::HTTP::Get, path, {}, {}, options, &blk)
    end

    def post(path, body = {}, options = {}, &blk)
      request(Net::HTTP::Post, path, body, {}, options, &blk)
    end

    def multipart_post(path, file = {}, options = {}, &blk)
      request(Net::HTTP::Post::Multipart, path, {}, file, options, &blk)
    end

    def path_with_options(path, options = {})
      !options.empty? ? %(#{path}?#{options.to_q}) : path
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
