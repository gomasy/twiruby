module TwiRuby
  module REST
    module Mutes
      # Mutes the user specified in the ID parameter for the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/mutes/users/create
      # @param options [Hash]
      def mute(options = {})
        @req.post("/1.1/mutes/users/create.json", options)
      end

      # Un-mutes the user specified in the ID parameter for the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/mutes/users/destroy
      # @param options [Hash]
      def unmute(options = {})
        @req.post("/1.1/mutes/users/destroy.json", options)
      end

      # Returns an array of numeric user ids the authenticating user has muted.
      #
      # @see https://dev.twitter.com/rest/reference/get/mutes/users/ids
      # @param options [Hash]
      def mutes_ids(options = {})
        @req.get("/1.1/mutes/users/ids.json", options)
      end

      # Returns an array of user objects the authenticating user has muted.
      #
      # @see https://dev.twitter.com/rest/reference/get/mutes/users/list
      # @param options [Hash]
      def mutes_list(options = {})
        @req.get("/1.1/mutes/users/list.json", options)
      end
    end
  end
end
