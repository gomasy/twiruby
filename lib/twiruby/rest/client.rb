require "twiruby/client"
require "twiruby/rest/timelines"
require "twiruby/rest/tweets"

module TwiRuby
  module REST
    class Client < TwiRuby::Client
      include REST::Timelines
      include REST::Tweets

      def initialize(options = {})
        super
        @req = REST::Request.new(tokens)
      end
    end
  end
end
