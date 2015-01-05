require "securerandom"
require "openssl"
require "base64"
require "erb"
require "uri"

require "twiruby/utils"

include ERB::Util
include TwiRuby::Utils

module TwiRuby
  module Headers
    OAUTH_VERSION = "1.0"
    OAUTH_SIGNATURE_METHOD = "HMAC-SHA1"

    class << self
      def generate_signature(tokens, oauth_signature_base)
        sign_key = "#{tokens[:consumer_secret]}&#{tokens[:access_token_secret]}"
        Base64.encode64(OpenSSL::HMAC.digest("sha1", sign_key, oauth_signature_base))
      end

      def generate_signature_base(tokens, http_method, url, oauth_nonce, oauth_timestamp, body = nil, options = {})
        parameters = build_query(generate_parameters(tokens, oauth_nonce, oauth_timestamp, nil, options))

        oauth_signature_base = "#{http_method}&#{url_encode(url)}&#{url_encode(parameters)}"
        oauth_signature_base << url_encode("&#{body}") if body != nil

        oauth_signature_base
      end

      def generate_header(tokens, http_method, url, body = nil, options = {})
        oauth_nonce = SecureRandom.hex
        oauth_timestamp = Time.now.to_i
        oauth_signature_base = generate_signature_base(tokens, http_method, url, oauth_nonce, oauth_timestamp, body, options)

        parameters = "OAuth "
        generate_parameters(tokens, oauth_nonce, oauth_timestamp, generate_signature(tokens, oauth_signature_base)).each do |key, value|
          parameters << "#{key}=\"#{url_encode(value)}\", "
        end

        parameters[0..parameters.length - 3]
      end

      def generate_parameters(tokens, oauth_nonce, oauth_timestamp, oauth_signature = nil, options = {})
        parameters = {}
        parameters.merge!(options) if !options.empty?

        parameters["oauth_consumer_key"] = tokens[:consumer_key]
        parameters["oauth_nonce"] = oauth_nonce
        parameters["oauth_signature"] = oauth_signature if oauth_signature != nil
        parameters["oauth_signature_method"] = OAUTH_SIGNATURE_METHOD
        parameters["oauth_timestamp"] = oauth_timestamp
        parameters["oauth_token"] = tokens[:access_token] if tokens[:access_token] != nil
        parameters["oauth_version"] = OAUTH_VERSION

        Hash[parameters.sort]
      end
    end
  end
end
