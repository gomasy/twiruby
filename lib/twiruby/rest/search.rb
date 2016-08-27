module TwiRuby
  module REST
    module Search
      # Returns a collection of relevant Tweets matching a specified query.
      #
      # @see https://dev.twitter.com/rest/reference/get/search/tweets
      # @param q [Integer, String]
      # @param options [Hash]
      def search(q, options = {})
        options[:q] = q
        @req.get("/1.1/search/tweets.json", options)
      end
    end
  end
end
