require "net/https"
require "erb"

module TwiRuby
  class Request
    attr_writer :user_agent

    def initialize(oauth)
      @oauth = oauth

      @https = Net::HTTP.new(OAuth::BASE_URL.host, OAuth::BASE_URL.port)
      @https.use_ssl = true
    end

    def request(method, path, body = nil, options = nil)
      header = {
        "Authorization" => @oauth.generate_header(method, "#{OAuth::BASE_URL}#{path}", body, options),
        "User-Agent" => user_agent
      }
      path = "#{path}?#{options.to_query}" if options != nil
      res = @https.send_request(method, path, body, header)

      case res.code.to_i
      when 200
        res
      else
        fail(Error.type(res.code.to_i), Error.parse_message(res))
      end
    end

    def get(path, options = nil)
      request("GET", path, nil, options)
    end

    def post(path, data = nil, options = nil)
      data = data != nil ? data.to_query : nil
      request("POST", path, data, options)
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
