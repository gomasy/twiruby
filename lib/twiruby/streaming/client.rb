require "twiruby/streaming/request"

module TwiRuby
  module Streaming
    class Client < TwiRuby::Client
      def initialize
        super
        @public = Streaming::Request.new(tokens, Streaming::PUBLIC_BASE_URL)
        @site = Streaming::Request.new(tokens, Streaming::SITE_BASE_URL)
        @user = Streaming::Request.new(tokens, Streaming::USER_BASE_URL)
      end

      def filter(options = {})
        @public.post("/1.1/statuses/filter.json") do |chunk|
          yield(chunk)
        end
      end

      def sample(options = {})
        @public.get("/1.1/statuses/sample.json") do |chunk|
          yield(chunk)
        end
      end

      def site(options = {})
        @site.get("/1.1/site.json") do |chunk|
          yield(chunk)
        end
      end

      def user(options = {})
        @user.get("/1.1/user.json") do |chunk|
          yield(chunk)
        end
      end
    end
  end
end
