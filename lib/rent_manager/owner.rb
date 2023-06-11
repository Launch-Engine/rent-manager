module RentManager
  class Owner < RentManagerRelation
    def self.base_path
      'Owners'
    end
  end
end
