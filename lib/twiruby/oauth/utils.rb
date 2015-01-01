require "securerandom"
require "openssl"
require "base64"
require "erb"
require "uri"

require "twiruby/utils"

include ERB::Util
include TwiRuby::Utils

module TwiRuby
  class OAuth
    module Utils
      OAUTH_VERSION = "1.0"
      OAUTH_SIGNATURE_METHOD = "HMAC-SHA1"

      def generate_signature(oauth_signature_base, sign_key)
        Base64.encode64(OpenSSL::HMAC.digest("sha1", sign_key, oauth_signature_base))
      end

      def generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body = nil, options = {})
        parameters = to_query(generate_parameters(oauth_nonce, oauth_timestamp, nil, options))

        oauth_signature_base = "#{http_method}&#{url_encode(url)}&#{url_encode(parameters)}"
        oauth_signature_base << url_encode("&#{body}") if body != nil

        oauth_signature_base
      end

      def generate_header(http_method, url, body = nil, options = {})
        oauth_nonce = SecureRandom.hex
        oauth_timestamp = Time.now.to_i
        oauth_signature_base = generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body, options)

        sign_key = "#{consumer_secret}&#{access_token_secret}"
        oauth_signature = generate_signature(oauth_signature_base, sign_key)

        parameters = "OAuth "
        generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature).each do |key, value|
          parameters << "#{key}=\"#{url_encode(value)}\", "
        end

        parameters[0..parameters.length - 3]
      end

      def generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature = nil, options = {})
        parameters = {}
        parameters["oauth_consumer_key"] = consumer_key
        parameters["oauth_nonce"] = oauth_nonce
        parameters["oauth_signature"] = oauth_signature if oauth_signature != nil
        parameters["oauth_signature_method"] = OAUTH_SIGNATURE_METHOD
        parameters["oauth_timestamp"] = oauth_timestamp
        parameters["oauth_token"] = access_token if access_token != nil
        parameters["oauth_version"] = OAUTH_VERSION
        parameters.update(options) if !options.empty?

        Hash[parameters.sort]
      end
    end
  end
end
