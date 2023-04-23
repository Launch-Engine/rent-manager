module RentManager
  class RentManagerError
    attr_reader :error
    attr_reader :errors
    attr_reader :error_code
    attr_reader :raw
    attr_reader :response_code

    def initialize(http_response)
      @raw = http_response
      @response_code = @raw.response_code

      data = JSON.parse(@raw.body, symbolize_names: true).to_snake_keys unless @raw.body.empty?
      if data.nil?
        set_default_error_message
      else
        @error = data[:user_message]
        @errors = data[:errors]
        @error_message = data[:error_code]
      end
    end

    def to_s
      @error
    end

    private

    def set_default_error_message
      require 'uri'
      api_path = URI.parse(@raw.effective_url).path
      @error = "Rent Manager API returned an error for #{api_path}."

      if @response_code == 401
        @error += ' Please check your credentials.'
      elsif @response_code == 404
        @error += ' Please check your API path.'
      end
    end
  end
end
