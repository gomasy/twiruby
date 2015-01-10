require "twiruby/client"
require "twiruby/streaming/request"

module TwiRuby
  module Streaming
    class Client < TwiRuby::Client
      def initialize(options = {})
        super
        @public = Streaming::Request.new(tokens, Streaming::PUBLIC_BASE_URL)
        @site = Streaming::Request.new(tokens, Streaming::SITE_BASE_URL)
        @user = Streaming::Request.new(tokens, Streaming::USER_BASE_URL)
      end

      # Returns public statuses that match one or more filter predicates.
      #
      # @see https://dev.twitter.com/streaming/reference/post/statuses/filter
      # @param options [Hash]
      def filter(options = {})
        @public.post("/1.1/statuses/filter.json", nil, options) do |chunk|
          yield(chunk)
        end
      end

      # Returns a small random sample of all public statuses.
      #
      # @see https://dev.twitter.com/streaming/reference/get/statuses/sample
      # @param options [Hash]
      def sample(options = {})
        @public.get("/1.1/statuses/sample.json", options) do |chunk|
          yield(chunk)
        end
      end

      # Site Streams allows services, such as web sites or mobile push services, to receive real-time updates for a large number of users.
      #
      # @see https://dev.twitter.com/streaming/reference/get/site
      # @param options [Hash]
      def site(options = {})
        @site.get("/1.1/site.json", options) do |chunk|
          yield(chunk)
        end
      end

      # User Streams provide a stream of data and events specific to the authenticated user.
      #
      # @see https://dev.twitter.com/streaming/reference/get/user
      # @param options [Hash]
      def user(options = {})
        @user.get("/1.1/user.json", options) do |chunk|
          yield(chunk)
        end
      end
    end
  end
end
