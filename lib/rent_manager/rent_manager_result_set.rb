module RentManager
  class RentManagerResultSet < RentManagerResultBase
    include Enumerable

    attr_reader :count
    alias size count

    attr_reader :total_count
    attr_reader :per_page
    attr_reader :page_number

    def initialize(http_response)
      super(http_response)

      @count = http_response.headers['x-results'].to_i
      @total_count = http_response.headers['x-total-results'].to_i

      begin
        options = JSON.parse(http_response.request.options[:params].to_snake_keys.to_json)
        @per_page = options['pagesize'].to_i
        @page_number = options['pagenumber'].to_i
      rescue JSON::ParserError
        @per_page = 0
        @page_number = 0
      end
    end

    def [](index)
      @attributes[index]
    end

    def each(&_block)
      @attributes.each { |result| yield(result) }
    end

    def empty?
      @count == 0
    end
  end
end
