require "securerandom"
require "openssl"
require "base64"
require "erb"

include ERB::Util

module TwiRuby
  class OAuth
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

    OAUTH_VERSION = "1.0"
    OAUTH_SIGNATURE_METHOD = "HMAC-SHA1"

    def initialize
      yield(self)
    end

    def generate_signature(http_method, url, oauth_nonce, oauth_timestamp, body = nil)
      oauth_signature_base = generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body)
      sign_key = "#{consumer_secret}&#{access_token_secret}"

      return Base64.encode64(OpenSSL::HMAC.digest("sha1", sign_key, oauth_signature_base))
    end

    def generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body = nil)
      parameters = ""
      generate_parameters(oauth_nonce, oauth_timestamp).each do |s|
        parameters << "#{s[0]}=#{s[1]}&"
      end
      parameters = parameters[0..parameters.length - 2]

      oauth_signature_base =
      "#{http_method}&" \
      "#{url_encode(url)}&" \
      "#{url_encode(
        "#{parameters}"
      )}"
      oauth_signature_base << url_encode("&#{body}") if body != nil

      return oauth_signature_base
    end

    def generate_header(http_method, url, body = nil)
      oauth_nonce = SecureRandom.hex
      oauth_timestamp = Time.now.to_i
      oauth_signature_base = generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body)
      oauth_signature = url_encode(generate_signature(http_method, url, oauth_nonce, oauth_timestamp, body))

      parameters = "OAuth "
      generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature).each do |s|
        parameters << "#{s[0]}=\"#{s[1]}\", "
      end

      return parameters[0..parameters.length - 3]
    end

    def generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature = nil)
      parameters = {}
      parameters["oauth_consumer_key"] = consumer_key
      parameters["oauth_nonce"] = oauth_nonce
      parameters["oauth_signature"] = oauth_signature if oauth_signature != nil
      parameters["oauth_signature_method"] = OAUTH_SIGNATURE_METHOD
      parameters["oauth_timestamp"] = oauth_timestamp
      parameters["oauth_token"] = access_token if access_token != nil
      parameters["oauth_version"] = OAUTH_VERSION

      return parameters
    end
  end
end
