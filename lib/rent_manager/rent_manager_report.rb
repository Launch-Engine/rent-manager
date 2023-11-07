module RentManager
  class RentManagerReport < RentManager::RecordBase
    include RentManager::RentManagerHelpers

    class << self
      def authenticate(args)
        new.authenticate(args)
      end

      def parameters(*args)
        new.parameters(args)
      end
    end

    def initialize
      @auth = {}
      @parameters = []
    end

    def authenticate(args)
      @auth = args.clone
      self
    end

    def parameters(*args)
      @parameters += arrayitize(args)
      self
    end

    def path
      "Reports/#{self.class.report_id}/RunReport"
    end

    def params
      retval = {}
      retval[:parameters] = @parameters.join(';') if @parameters.any?
      retval
    end

    def process
      self.class.fetch_report(path, params.merge(@auth))
    end
  end
end
