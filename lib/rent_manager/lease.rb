module RentManager
  class Lease < RentManagerRelation
    def self.base_path
      'Leases'
    end
  end
end
