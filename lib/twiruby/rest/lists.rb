module TwiRuby
  module REST
    module Lists
      # Returns all lists the authenticating or specified user subscribes to, including their own.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/list
      # @param options [Hash]
      def list(options = {})
        @req.get("/1.1/lists/list.json", options)
      end

      # Returns a timeline of tweets authored by members of the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/statuses
      # @param options [Hash]
      def lists_statuses(options = {})
        @req.get("/1.1/lists/statuses.json", options)
      end

      # Removes the specified member from the list.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/members/destroy
      # @param options [Hash]
      def lists_members_destroy(options = {})
        @req.post("/1.1/lists/members/destroy.json", options)
      end

      # Returns the lists the specified user has been added to.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/memberships
      # @param options [Hash]
      def lists_memberships(options = {})
        @req.get("/1.1/lists/memberships.json", options)
      end

      # Returns the subscribers of the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/subscribers
      # @param options [Hash]
      def lists_subscribers(options = {})
        @req.get("/1.1/lists/subscribers.json", options)
      end

      # Subscribes the authenticated user to the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/subscribers/create
      # @param options [Hash]
      def lists_subscribers_create(options = {})
        @req.post("/1.1/lists/subscribers/create.json", options)
      end

      # Check if the specified user is a subscriber of the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/subscribers/show
      # @param options [Hash]
      def lists_subscribers_show(options = {})
        @req.get("/1.1/lists/subscribers/show.json", options)
      end

      # Unsubscribes the authenticated user from the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/subscribers/destroy
      # @param options [Hash]
      def lists_subscribers_destroy(options = {})
        @req.post("/1.1/lists/subscribers/destroy.json", options)
      end

      # Adds multiple members to a list, by specifying a comma-separated list of member ids or screen names.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/members/create_all
      # @param options [Hash]
      def lists_members_create_all(options = {})
        @req.post("/1.1/lists/members/create_all.json", options)
      end

      # Check if the specified user is a member of the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/members/show
      # @param options [Hash]
      def lists_members_show(options = {})
        @req.get("/1.1/lists/members/show.json", options)
      end

      # Returns the members of the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/members
      # @param options [Hash]
      def lists_members(options = {})
        @req.get("/1.1/lists/members.json", options)
      end

      # Add a member to a list.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/members/create
      # @param options [Hash]
      def lists_members_create(options = {})
        @req.post("/1.1/lists/members/create.json", options)
      end

      # Deletes the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/destroy
      # @param options [Hash]
      def lists_destroy(options = {})
        @req.post("/1.1/lists/destroy.json", options)
      end

      # Updates the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/update
      # @param options [Hash]
      def lists_update(options = {})
        @req.post("/1.1/lists/update.json", options)
      end

      # Creates a new list for the authenticated user.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/create
      # @param options [Hash]
      def lists_create(options = {})
        @req.post("/1.1/lists/create.json", options)
      end

      # Returns the specified list.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/show
      # @param options [Hash]
      def lists_show(options = {})
        @req.get("/1.1/lists/show.json", options)
      end

      # Obtain a collection of the lists the specified user is subscribed to, 20 lists per page by default.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/subscriptions
      # @param options [Hash]
      def lists_subscriptions(options = {})
        @req.get("/1.1/lists/subscriptions.json", options)
      end

      # Removes multiple members from a list, by specifying a comma-separated list of member ids or screen names.
      #
      # @see https://dev.twitter.com/rest/reference/post/lists/members/destroy_all
      # @param options [Hash]
      def lists_members_destroy_all(options = {})
        @req.post("/1.1/lists/members/destroy_all.json", options)
      end

      # Returns the lists owned by the specified Twitter user.
      #
      # @see https://dev.twitter.com/rest/reference/get/lists/ownerships
      # @param options [Hash]
      def lists_ownerships(options = {})
        @req.get("/1.1/lists/ownerships.json", options)
      end
    end
  end
end
