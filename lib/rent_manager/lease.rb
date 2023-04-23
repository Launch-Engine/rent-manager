module RentManager
  class Lease < RentManagerRelation
    def self.base_path
      'Leases'
    end

    def self.join_tables
      [
        :create_user,
        :lease_renewals,
        :property,
        :renter_insurance_policies,
        :retail_sales,
        :tenant,
        :unit,
        :update_user
      ]
    end
  end
end
