module TwiRuby
  module REST
    module Account
      # Updates the authenticating user’s settings.
      #
      # @see https://dev.twitter.com/rest/reference/post/account/settings
      # @param options [Hash]
      def settings(options = {})
        @req.post("/1.1/account/settings.json", options)
      end
    end
  end
end
