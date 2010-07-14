module SimpleGeocoder
  # contains the Net::HTTP response object accessible via the {#response} method.
  class ResponseError < StandardError
    # response of the last request
    # @return [Net::HTTPResponse] A subclass of Net::HTTPResponse, e.g.
    # Net::HTTPOK
    attr_reader :response

    # Instantiate an instance of ResponseError with a Net::HTTPResponse object
    # @param [Net::HTTPResponse]
    def initialize(response)
      @response = response
    end
  end
end