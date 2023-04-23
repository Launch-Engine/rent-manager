module RentManager
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= RentManager::Configuration.new
      yield(configuration)
    end

    def reset
      self.configuration = RentManager::Configuration.new
    end
  end
end
