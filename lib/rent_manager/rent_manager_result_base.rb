module RentManager
  class RentManagerResultBase
    attr_reader :attributes

    attr_reader :rate_limit
    attr_reader :remaining
    attr_reader :reset

    attr_reader :raw

    def initialize(http_response)
      @raw = http_response

      # Remove BOM (Byte Order Marker) from response body
      body_data = http_response.body.force_encoding("UTF-8")
      body_data = body_data.gsub("\xEF\xBB\xBF".force_encoding("UTF-8"), '')

      begin
        @attributes = JSON.parse(body_data, symbolize_names: true).to_snake_keys
      rescue JSON::ParserError
        @attributes = []
      end

      @rate_limit = http_response.headers['x-ratelimit-limit'].to_i
      @remaining = http_response.headers['x-ratelimit-remaining'].to_i
      @reset = http_response.headers['x-ratelimit-reset'].to_i
    end
  end
end
