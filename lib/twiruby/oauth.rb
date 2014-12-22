require "securerandom"
require "openssl"
require "base64"
require "erb"
require "uri"

include ERB::Util

module TwiRuby
  class OAuth
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

    OAUTH_VERSION = "1.0"
    OAUTH_SIGNATURE_METHOD = "HMAC-SHA1"

    def generate_signature
      # TODO
    end

    #
    # @params http_method [String]
    # @params url [URI, String]
    # @params oauth_nonce [String]
    # @params oauth_timestamp [String]
    # @params body [hash]
    def generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body = nil)
      parameters = ""
      generate_parameters(oauth_nonce, oauth_timestamp).each do |s|
        parameters << "#{s[0]}=#{s[1]}&"
      end
      parameters = parameters[0..parameters.length - 2]

      oauth_signature_base =
        "#{http_method}&" \
        "#{url_encode(url)}&" \
        "#{url_encode(parameters)}"
      oauth_signature_base << "&#{body}" if body != nil
      return oauth_signature_base
    end

    def generate_header(http_method, url)
      # TODO
      oauth_nonce = SecureRandom.hex
      oauth_timestamp = Time.now.to_i

      parameters = generate_parameters(oauth_nonce, oauth_timestamp)
    end

    def generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature = nil)
      parameters = {}
      parameters["oauth_consumer_key"] = consumer_key
      parameters["oauth_nonce"] = oauth_nonce
      parameters["oauth_signature"] = oauth_signature if oauth_signature != nil
      parameters["oauth_signature_method"] = OAUTH_SIGNATURE_METHOD
      parameters["oauth_timestamp"] = oauth_timestamp
      parameters["oauth_token"] = access_token if has_token
      parameters["oauth_version"] = OAUTH_VERSION

      return parameters
    end

    def to_join(hash, split = nil)
      hash.map{|s|"#{s[0]}=#{split}#{s[1]}#{split}"}
    end

    def has_token
      !!(access_token && access_token_secret)
    end
  end
end
