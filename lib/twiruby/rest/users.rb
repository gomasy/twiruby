module TwiRuby
  module REST
    module Users
      # Returns fully-hydrated user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id and/or screen_name parameters.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/lookup
      # @param options [Hash]
      def lookup(options = {})
        @req.get("/1.1/users/lookup.json", options)
      end

      # Returns a variety of information about the user specified by the required user_id or screen_name parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/show
      # @param options [Hash]
      def show(options = {})
        @req.get("/1.1/users/show.json", options)
      end

      # Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/search
      # @param options [Hash]
      def search(options = {})
        @req.get("/1.1/users/search.json", options)
      end

      # Access to Twitter’s suggested user list.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/suggestions
      # @param options [Hash]
      def suggestions(options = {})
        @req.get("/1.1/users/suggestions.json", options)
      end

      # Access the users in a given category of the Twitter suggested user list.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/suggestions/:slug
      # @param slug [String]
      # @param options [Hash]
      def suggestions_slug(slug, options = {})
        @req.get("/1.1/users/suggestions/#{slug}.json", options)
      end

      # Access the users in a given category of the Twitter suggested user list and return their most recent status if they are not a protected user.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/suggestions/%3Aslug/members
      # @param slug [String]
      def suggestions_slug_members(slug)
        @req.get("/1.1/users/suggestions/#{slug}/members.json")
      end
    end
  end
end
