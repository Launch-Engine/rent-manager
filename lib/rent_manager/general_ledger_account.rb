module RentManager
  class GeneralLedgerAccount < RentManagerRelation
    def self.base_path
      'GLAccounts'
    end

    def self.join_tables
      [
        :create_user,
        :general_ledger_account_type,
        :update_user
      ]
    end
  end
end
