module TwiRuby
  module REST
    module Account
      # Returns settings (including current trend, geo and sleep time information) for the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/get/account/settings
      def settings
        @req.get("https://api.twitter.com/1.1/account/settings.json")
      end

      # Updates the authenticating user’s settings.
      #
      # @see https://dev.twitter.com/rest/reference/post/account/settings
      # @param options [Hash]
      def update_settings(options = {})
        @req.post("/1.1/account/settings.json", nil, options)
      end

      # Representation of the requesting user.
      #
      # @see https://dev.twitter.com/rest/reference/get/account/verify_credentials
      # @param options [Hash]
      def verify_credentials(options = {})
        @req.get("/1.1/account/verify_credentials.json", options)
      end

      # Sets some values that users are able to set under the “Account” tab of their settings page.
      #
      # @see https://dev.twitter.com/rest/reference/post/account/update_profile
      # @param options [Hash]
      def update_profile(options = {})
        @req.post("/1.1/account/update_profile.json", nil, options)
      end

      # Updates the authenticating user’s profile image. Note that this method expects raw multipart data, not a URL to an image.
      #
      # @see https://dev.twitter.com/rest/reference/post/account/update_profile_image
      # @param image [String]
      # @param options [Hash]
      def update_profile_image(image, options = {})
        @req.multipart_post("/1.1/account/update_profile_image.json", { :image => image }, options)
      end

      # Removes the uploaded profile banner for the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/account/remove_profile_banner
      def remove_profile_banner
        @req.post("/1.1/account/remove_profile_banner.json")
      end

      # Uploads a profile banner on behalf of the authenticating user.
      #
      # @see https://dev.twitter.com/rest/reference/post/account/update_profile_banner
      # @param banner [String]
      # @param options [Hash]
      def update_profile_banner(banner, options = {})
        @req.multipart_post("/1.1/account/update_profile_banner.json", { :banner => banner }, options)
      end
    end
  end
end
