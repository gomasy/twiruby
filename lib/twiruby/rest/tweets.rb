module TwiRuby
  module REST
    module Tweets
      # Returns the destroyed status if successful.
      #
      # @see https://dev.twitter.com/rest/reference/post/statuses/destroy/:id
      # @param id [Integer, String]
      # @param options [Hash]
      def destroy_status(id, options = {})
        @req.post("/1.1/statuses/destroy/#{id}.json", nil, options)
      end

      # Returns fully-hydrated tweet objects for up to 100 tweets per request, as specified by comma-separated values passed to the id parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/lookup
      # @param id [Array<Integer>, Array<String>]
      # @param options [Hash]
      def lookup(id, options = {})
        options[:id] = id.join(",")
        @req.get("/1.1/statuses/lookup.json", options)
      end

      # Returns a single Tweet, specified by either a Tweet web URL or the Tweet ID, in an oEmbed-compatible format.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/oembed
      # @param options [Hash]
      def oembed(options = {})
        @req.get("/1.1/statuses/oembed.json", options)
      end

      # Returns the original tweet with retweet details embedded.
      #
      # @see https://dev.twitter.com/rest/reference/post/statuses/retweet/:id
      # @param id [Integer, String]
      # @param options [Hash]
      def retweet(id, options = {})
        @req.post("/1.1/statuses/retweet/#{id}.json", nil, options)
      end

      # Returns the original Tweet with retweet details embedded.
      #
      # @see https://dev.twitter.com/rest/reference/post/statuses/unretweet/:id
      # @param id [Integer, String]
      # @param options [Hash]
      def unretweet(id, options = {})
        @req.post("/1.1/statuses/unretweet/#{id}.json", nil, options)
      end

      # Returns a collection of the 100 most recent retweets of the tweet specified by the id parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/retweets/:id
      # @param id [Integer, String]
      # @param options [Hash]
      def retweets(id, options = {})
        @req.get("/1.1/statuses/retweets/#{id}.json", options)
      end

      # Returns a collection of up to 100 user IDs belonging to users who have retweeted the tweet specified by the id parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids
      # @param id [Integer, String]
      def retweeters(id, options = {})
        options[:id] = id
        @req.get("/1.1/statuses/retweeters/ids.json", options)
      end

      # Returns a single Tweet, specified by the id parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/statuses/show/:id
      # @param id [Integer, String]
      # @param options [Hash]
      def show_status(id, options = {})
        @req.get("/1.1/statuses/show/#{id}.json", options)
      end

      # Updates the authenticating user’s current status, also known as tweeting.
      #
      # @see https://dev.twitter.com/rest/reference/post/statuses/update
      # @param status [Integer, String]
      # @param options [Hash]
      def update(status, options = {})
        @req.post("/1.1/statuses/update.json", { :status => status }, options)
      end
    end
  end
end
