require "net/https"
require "erb"

include ERB::Util

module TwiRuby
  class Request
    attr_writer :user_agent

    def initialize(oauth)
      @oauth = oauth

      @https = Net::HTTP.new(@oauth.base_url.host, @oauth.base_url.port)
      @https.use_ssl = true
      @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    def request(method, path, body = nil, options = nil)
      header = {
        "Authorization" => @oauth.generate_header(method, "#{@oauth.base_url}#{path}", body, options),
        "User-Agent" => user_agent
      }
      path = "#{path}?#{to_query(options)}" if options != nil

      @https.send_request(method, path, body, header)
    end

    def get(path, options = nil)
      request("GET", path, nil, options)
    end

    def post(path, data = nil, options = nil)
      data = data != nil ? to_query(data) : nil
      request("POST", path, data, options)
    end

    def to_query(hash)
      str = ""
      hash.each do |s|
        str << "#{s[0]}=#{url_encode(s[1])}&"
      end

      return str[0..str.length - 2]
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
