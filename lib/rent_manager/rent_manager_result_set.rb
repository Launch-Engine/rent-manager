module RentManager
  class RentManagerResultSet < RentManagerResultBase
    attr_reader :count
    attr_reader :total_count
    attr_reader :per_page
    attr_reader :page_number

    def initialize(http_response)
      super(http_response)

      @count = http_response.headers['x-results'].to_i
      @total_count = http_response.headers['x-total-results'].to_i

      options = JSON.parse(http_response.request.options[:params].to_snake_keys.to_json)
      @per_page = options['pagesize'].to_i
      @page_number = options['pagenumber'].to_i
    end
  end
end
