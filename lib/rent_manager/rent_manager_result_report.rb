module RentManager
  class RentManagerResultReport < RentManagerResultBase
    include Enumerable

    attr_reader :count
    alias size count

    attr_reader :total_count
    attr_reader :per_page
    attr_reader :page_number

    def initialize(http_response)
      super(http_response)
      options = JSON.parse(http_response.request.options[:params].to_snake_keys.to_json)
    end

    def [](index)
      @attributes[index]
    end
  end
end
