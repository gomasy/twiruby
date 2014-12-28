require "securerandom"
require "openssl"
require "base64"
require "erb"
require "uri"

include ERB::Util

class Hash
  def to_query
    str = ""
    self.each do |s|
      str << "#{s[0]}=#{url_encode(s[1])}&"
    end

    return str[0..str.length - 2]
  end
end

module TwiRuby
  class OAuth
    module Utils
      OAUTH_VERSION = "1.0"
      OAUTH_SIGNATURE_METHOD = "HMAC-SHA1"

      def generate_signature(oauth_signature_base, sign_key)
        Base64.encode64(OpenSSL::HMAC.digest("sha1", sign_key, oauth_signature_base))
      end

      def generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body = nil, options = nil)
        parameters = generate_parameters(oauth_nonce, oauth_timestamp, nil, options).to_query

        oauth_signature_base = "#{http_method}&#{url_encode(url)}&#{url_encode(parameters)}"
        oauth_signature_base << url_encode("&#{body}") if body != nil

        return oauth_signature_base
      end

      def generate_header(http_method, url, body = nil, options = nil)
        oauth_nonce = SecureRandom.hex
        oauth_timestamp = Time.now.to_i
        oauth_signature_base = generate_signature_base(http_method, url, oauth_nonce, oauth_timestamp, body, options)

        sign_key = "#{consumer_secret}&#{access_token_secret}"
        oauth_signature = url_encode(generate_signature(oauth_signature_base, sign_key))

        parameters = "OAuth "
        generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature).each do |s|
          parameters << "#{s[0]}=\"#{s[1]}\", "
        end

        return parameters[0..parameters.length - 3]
      end

      def generate_parameters(oauth_nonce, oauth_timestamp, oauth_signature = nil, options = nil)
        parameters = {}
        parameters["oauth_consumer_key"] = consumer_key
        parameters["oauth_nonce"] = oauth_nonce
        parameters["oauth_signature"] = oauth_signature if oauth_signature != nil
        parameters["oauth_signature_method"] = OAUTH_SIGNATURE_METHOD
        parameters["oauth_timestamp"] = oauth_timestamp
        parameters["oauth_token"] = access_token if access_token != nil
        parameters["oauth_version"] = OAUTH_VERSION
        parameters.update(options) if options != nil

        return Hash[parameters.sort]
      end
    end
  end
end
