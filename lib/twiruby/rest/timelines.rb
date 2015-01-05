module TwiRuby
  module REST
    module Timelines
      # Returns a collection of the most recent Tweets and retweets posted by the authenticating user and the users they follow.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/home_timeline
      # @param options [Hash]
      def home_timeline(options = {})
        @req.get("/1.1/statuses/home_timeline.json", options)
      end

      # Returns the 20 most recent mentions (tweets containing a users’s @screen_name) for the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline
      # @param options [Hash]
      def mentions_timeline(options = {})
        @req.get("/1.1/statuses/mentions_timeline.json", options)
      end

      # Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/user_timeline
      # @param options [Hash]
      def user_timeline(options = {})
        @req.get("/1.1/statuses/user_timeline.json", options)
      end

      # Returns the most recent tweets authored by the authenticating user that have been retweeted by others.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me
      # @param options [Hash]
      def retweets_of_me(options = {})
        @req.get("/1.1/statuses/retweets_of_me.json", options)
      end
    end
  end
end
