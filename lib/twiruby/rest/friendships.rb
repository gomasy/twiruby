module TwiRuby
  module REST
    module Friendships
      # Returns a collection of user_ids that the currently authenticated user does not want to receive retweets from.
      #
      # @see https://dev.twitter.com/rest/reference/get/friendships/no_retweets/ids
      # @param options [Hash]
      def friendships_no_retweets(options = {})
        @req.get("/1.1/friendships/no_retweets/ids.json", options)
      end

      # Returns a collection of numeric IDs for every user who has a pending request to follow the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/get/friendships/incoming
      # @param options [Hash]
      def friendships_incoming(options = {})
        @req.get("/1.1/friendships/incoming.json", options)
      end

      # Returns a collection of numeric IDs for every protected user for whom the authenticating user has a pending follow request.
      #
      # @see https://dev.twitter.com/rest/reference/get/friendships/outgoing
      # @param options [Hash]
      def friendships_outgoing(options = {})
        @req.get("/1.1/friendships/outgoing.json", options)
      end

      # Allows the authenticating users to follow the user specified in the ID parameter.
      #
      # @see https://dev.twitter.com/rest/reference/post/friendships/create
      # @param options [Hash]
      def friendships_create(options = {})
        @req.post("/1.1/friendships/create.json", options)
      end

      # Allows the authenticating user to unfollow the user specified in the ID parameter.
      #
      # @see https://dev.twitter.com/rest/reference/post/friendships/destroy
      # @param options [Hash]
      def friendships_destroy(options = {})
        @req.post("/1.1/friendships/destroy.json", options)
      end

      # Allows one to enable or disable retweets and device notifications from the specified user.
      #
      # @see https://dev.twitter.com/rest/reference/post/friendships/update
      # @param options [Hash]
      def friendships_update(options = {})
        @req.post("/1.1/friendships/update.json", options)
      end

      # Returns detailed information about the relationship between two arbitrary users.
      #
      # @see https://dev.twitter.com/rest/reference/get/friendships/show
      # @param options [Hash]
      def friendships_show(options = {})
        @req.get("/1.1/friendships/show.json", options)
      end
    end
  end
end
