module RentManager
  class Tenant < RentManagerRelation
    def self.base_path
      'Tenants'
    end
  end
end
