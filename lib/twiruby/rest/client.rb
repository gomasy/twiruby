require "twiruby/client"
require "twiruby/rest/account"
require "twiruby/rest/blocks"
require "twiruby/rest/favorites"
require "twiruby/rest/request"
require "twiruby/rest/timelines"
require "twiruby/rest/tweets"
require "twiruby/rest/users"

module TwiRuby
  module REST
    class Client < TwiRuby::Client
      include REST::Account
      include REST::Blocks
      include REST::Favorites
      include REST::Timelines
      include REST::Tweets
      include REST::Users

      def initialize(options = {})
        super
        @req = REST::Request.new(tokens)
      end
    end
  end
end
