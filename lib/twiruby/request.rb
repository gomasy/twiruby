require "net/https"

module TwiRuby
  class Request < Net::HTTP
    attr_writer :user_agent

    def request(req, body = nil, &block)
      self.use_ssl = true
      req["User-Agent"] = user_agent
      super
    end

    def get_request(path, consumer_key, consumer_secret, token = nil, token_secret = nil)
      # TODO
    end

    def post_request(path, consumer_key, consumer_secret, token = nil, token_secret = nil, data = nil)
      # TODO
    end

    def user_agent
      @user_agent ||= "TwiRuby gem/#{TwiRuby::VERSION}"
    end
  end
end
