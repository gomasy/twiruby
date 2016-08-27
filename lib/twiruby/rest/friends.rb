module TwiRuby
  module REST
    module Friends
      # Returns a cursored collection of user IDs for every user the specified user is following (otherwise known as their “friends”).
      #
      # @see https://dev.twitter.com/rest/reference/get/friends/ids
      # @param options [Hash]
      def friends_ids(options = {})
        @req.get("/1.1/friends/ids.json", options)
      end

      # Returns a cursored collection of user objects for every user the specified user is following (otherwise known as their “friends”).
      #
      # @see https://dev.twitter.com/rest/reference/get/friends/list
      # @param options [Hash]
      def friends_list(options = {})
        @req.get("/1.1/friends/list.json", options)
      end
    end
  end
end
