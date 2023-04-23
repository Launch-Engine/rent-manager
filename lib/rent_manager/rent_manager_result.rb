module RentManager
  class RentManagerResult < RentManagerResultBase
    def initialize(http_response)
      super(http_response)
    end

    def method_missing(m, *args, &block)
      if @attributes.key?(m.to_sym)
        @attributes[m.to_sym]
      else
        raise NoMethodError.new("Method `#{m}` does not exist.")
      end
    end
  end
end
