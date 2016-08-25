module TwiRuby
  module REST
    module Favorites
      # Returns the 20 most recent Tweets liked by the authenticating or specified user.
      #
      # @see https://dev.twitter.com/rest/reference/get/favorites/list
      # @param options [Hash]
      def favorites_list(options = {})
        @req.get("/1.1/favorites/list.json", options)
      end

      # Un-likes the status specified in the ID parameter as the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/favorites/destroy
      # @param id [Integer, String]
      # @param options [Hash]
      def favorites_destroy(id, options = {})
        options[:id] = id
        @req.post("/1.1/favorites/destroy.json", options)
      end

      # Likes the status specified in the ID parameter as the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/favorites/create
      # @param id [Integer, String]
      # @param options [Hash]
      def favorites_create(id, options = {})
        options[:id] = id
        @req.post("/1.1/favorites/create.json", options)
      end
    end
  end
end
