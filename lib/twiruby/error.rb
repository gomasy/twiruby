module TwiRuby
  class Error < StandardError
    # HTTP status code 304
    NotModified = Class.new(self)

    # HTTP status code 400
    BadRequest = Class.new(self)

    # HTTP status code 401
    Unauthorized = Class.new(self)

    # HTTP status code 403
    Forbidden = Class.new(self)

    # HTTP status code 404
    NotFound = Class.new(self)

    # HTTP status code 406
    NotAcceptable = Class.new(self)

    # HTTP status code 410
    Gone = Class.new(self)

    # HTTP status code 420
    EnhanceYourCalm = Class.new(self)

    # HTTP status code 422
    UnprocessableEntity = Class.new(self)

    # HTTP status code 429
    TooManyRequests = Class.new(self)

    # HTTP status code 500
    InternalServerError = Class.new(self)

    # HTTP status code 502
    BadGateway = Class.new(self)

    # HTTP status code 503
    ServiceUnavailable = Class.new(self)

    # HTTP status code 504
    GatewayTimeout = Class.new(self)

    ERRORS = {
      "304" => NotModified,
      "400" => BadRequest,
      "401" => Unauthorized,
      "403" => Forbidden,
      "404" => NotFound,
      "406" => NotAcceptable,
      "410" => Gone,
      "420" => EnhanceYourCalm,
      "422" => UnprocessableEntity,
      "429" => TooManyRequests,
      "500" => InternalServerError,
      "502" => BadGateway,
      "503" => ServiceUnavailable,
      "504" => GatewayTimeout
    }

    class << self
      def raise(code)
        ERRORS[code]
      end
    end
  end
end