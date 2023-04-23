module RentManager
  class RentManagerResultBase
    attr_reader :attributes

    attr_reader :rate_limit
    attr_reader :remaining
    attr_reader :reset

    attr_reader :raw

    def initialize(http_response)
      @raw = http_response
      @attributes = JSON.parse(http_response.body, symbolize_names: true).to_snake_keys

      @rate_limit = http_response.headers['x-ratelimit-limit'].to_i
      @remaining = http_response.headers['x-ratelimit-remaining'].to_i
      @reset = http_response.headers['x-ratelimit-reset'].to_i
    end
  end
end
