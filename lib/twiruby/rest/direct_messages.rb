module TwiRuby
  module REST
    module DirectMessages
      # Returns the 20 most recent direct messages sent by the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/get/direct_messages/sent
      # @param options [Hash]
      def direct_messages_sent(options = {})
        @req.get("/1.1/direct_messages/sent.json", options)
      end

      # Returns a single direct message, specified by an id parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/direct_messages/show
      # @param id [Integer, String]
      def direct_messages_show(id)
        @req.get("/1.1/direct_messages/show.json", :id => id)
      end

      # Returns the 20 most recent direct messages sent to the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/get/direct_messages
      # @param options [Hash]
      def direct_messages(options = {})
        @req.get("/1.1/direct_messages.json", options)
      end

      # Destroys the direct message specified in the required ID parameter.
      #
      # @see https://dev.twitter.com/rest/reference/post/direct_messages/destroy
      # @param id [Integer, String]
      # @param options [Hash]
      def direct_messages_destroy(id, options = {})
        options[:id] = id
        @req.post("/1.1/direct_messages/destroy.json", options)
      end

      # Sends a new direct message to the specified user from the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/direct_messages/new
      # @param text [Integer, String]
      # @param options [Hash]
      def direct_messages_create(text, options = {})
        options[:text] = text
        @req.post("/1.1/direct_messages/new.json", options)
      end
    end
  end
end
