module RentManager
  class Owner < RentManagerRelation
    def self.base_path
      'Owners'
    end

    def self.join_tables
      [
        :addresses,
        :balance_account,
        :billable_expenses,
        :charges,
        :color,
        :contact,
        :contribution_account,
        :create_user,
        :draw_account,
        :epay_info,
        :history,
        :history_calls,
        :history_emails,
        :history_notes,
        :history_system_notes,
        :history_visits,
        :history_with_unit_history,
        :nacha_owner_bank,
        :owner_checks,
        :owner_contracts,
        :owner_group_details,
        :owner_groups,
        :owner_web_access_owner_preference,
        :owner_web_access_report_privileges,
        :ownerships,
        :payments,
        :phone_numbers,
        :rm_vo_ip_call_history,
        :update_user,
        :user_defined_values,
        :web_user_accounts,
        :web_users
      ]
    end
  end
end
