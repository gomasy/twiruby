module TwiRuby
  class Error < StandardError
    # HTTP status code 401
    Unauthorized = Class.new(self)

    ERRORS = {
      "401" => Unauthorized
    }

    class << self
      def raise(code)
        ERRORS[code]
      end
    end
  end
end
