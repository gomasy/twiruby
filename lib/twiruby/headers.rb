require "base64"
require "erb"
require "openssl"
require "securerandom"
require "uri"

require "twiruby/utils"

include ERB::Util

module TwiRuby
  class Headers
    attr_reader :oauth_header, :oauth_nonce, :oauth_timestamp, :oauth_signature, :oauth_signature_base

    OAUTH_VERSION = "1.0"
    OAUTH_SIGNATURE_METHOD = "HMAC-SHA1"

    def initialize(tokens, http_method, url, body = nil, options = {})
      @oauth_nonce = SecureRandom.hex
      @oauth_timestamp = Time.now.to_i
      @oauth_signature_base = Headers.generate_signature_base(tokens, http_method, url, oauth_nonce, oauth_timestamp, body, options)
      @oauth_signature = Headers.generate_signature(tokens, oauth_signature_base)
      @oauth_header = Headers.generate_parameters(tokens, oauth_nonce, oauth_timestamp, oauth_signature)
    end

    def to_s
      str = "OAuth "
      oauth_header.each do |k, v|
        str << %(#{k}="#{url_encode(v)}", )
      end

      str[0..str.length - 3]
    end

    class << self
      def generate_signature(tokens, oauth_signature_base)
        sign_key = %(#{tokens[:consumer_secret]}&#{tokens[:oauth_token_secret]})
        Base64.encode64(OpenSSL::HMAC.digest("sha1", sign_key, oauth_signature_base)).chomp
      end

      def generate_signature_base(tokens, http_method, url, oauth_nonce, oauth_timestamp, body = nil, options = {})
        query = generate_parameters(tokens, oauth_nonce, oauth_timestamp, nil, options).to_q

        oauth_signature_base = %(#{http_method}&#{url_encode(url)}&#{url_encode(query)})
        oauth_signature_base << url_encode("&#{body}") if !body.nil?

        oauth_signature_base
      end

      def generate_parameters(tokens, oauth_nonce, oauth_timestamp, oauth_signature = nil, params = {})
        params[:oauth_consumer_key] = tokens[:consumer_key]
        params[:oauth_nonce] = oauth_nonce
        params[:oauth_signature] = oauth_signature if !oauth_signature.nil?
        params[:oauth_signature_method] = OAUTH_SIGNATURE_METHOD
        params[:oauth_timestamp] = oauth_timestamp
        params[:oauth_token] = tokens[:oauth_token] if !tokens[:oauth_token].nil?
        params[:oauth_version] = OAUTH_VERSION

        Hash[params.sort].symbolize_keys
      end
    end
  end
end
