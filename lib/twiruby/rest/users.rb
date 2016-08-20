module TwiRuby
  module REST
    module Users
      # Returns fully-hydrated user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id and/or screen_name parameters.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/lookup
      # @param options [Hash]
      def users_lookup(options = {})
        @req.get("/1.1/users/lookup.json", options)
      end

      # Returns a variety of information about the user specified by the required user_id or screen_name parameter.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/show
      # @param options [Hash]
      def users_show(options = {})
        @req.get("/1.1/users/show.json", options)
      end

      # Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/search
      # @param options [Hash]
      def search(q, options = {})
        options[:q] = q
        @req.get("/1.1/users/search.json", options)
      end

      # Returns a map of the available size variations of the specified user’s profile banner.
      #
      # @see https://dev.twitter.com/rest/reference/get/users/profile_banner
      # @param options [Hash]
      def profile_banner(options = {})
        @req.get("/1.1/users/profile_banner.json", options)
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
      # @see https://dev.twitter.com/rest/reference/get/users/suggestions/:slug/members
      # @param slug [String]
      def suggestions_slug_members(slug)
        @req.get("/1.1/users/suggestions/#{slug}/members.json")
      end

      # Report the specified user as a spam account to Twitter.
      #
      # @see https://dev.twitter.com/rest/reference/post/users/report_spam
      # @param options [Hash]
      def report_spam(options)
        @req.post("/1.1/users/report_spam.json", options)
      end
    end
  end
end
