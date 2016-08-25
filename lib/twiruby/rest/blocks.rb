require "twiruby"

module TwiRuby
  module REST
    module Blocks
      # Returns a collection of user objects that the authenticating user is blocking.
      #
      # @see https://dev.twitter.com/rest/reference/get/blocks/list
      # @param options [Hash]
      def blocks_list(options = {})
        @req.get("/1.1/blocks/list.json", options)
      end

      # Returns an array of numeric user ids the authenticating user is blocking.
      #
      # @see https://dev.twitter.com/rest/reference/get/blocks/ids
      # @param options [Hash]
      def blocks_ids(options = {})
        @req.get("/1.1/blocks/ids.json", options)
      end

      # Blocks the specified user from following the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/blocks/create
      # @param options [Hash]
      def blocks_create(options = {})
        @req.post("/1.1/blocks/create.json", options)
      end

      # Un-blocks the user specified in the ID parameter for the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/blocks/destroy
      # @param options [Hash]
      def blocks_destroy(options = {})
        @req.post("/1.1/blocks/destroy.json", options)
      end
    end
  end
end
