require "twiruby/client"
require "twiruby/rest/account"
require "twiruby/rest/blocks"
require "twiruby/rest/direct_messages"
require "twiruby/rest/favorites"
require "twiruby/rest/followers"
require "twiruby/rest/friends"
require "twiruby/rest/friendships"
require "twiruby/rest/lists"
require "twiruby/rest/mutes"
require "twiruby/rest/request"
require "twiruby/rest/search"
require "twiruby/rest/timelines"
require "twiruby/rest/tweets"
require "twiruby/rest/users"

module TwiRuby
  module REST
    class Client < TwiRuby::Client
      include REST::Account
      include REST::Blocks
      include REST::DirectMessages
      include REST::Favorites
      include REST::Followers
      include REST::Friends
      include REST::Friendships
      include REST::Lists
      include REST::Mutes
      include REST::Search
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
