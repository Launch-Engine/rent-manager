require 'pry-byebug'
require './lib/rent_manager'

# RentManager.configure do |config|
#   config.company_code = ENV['RENT_MANAGER_COMPANY_CODE']
#   config.username = ENV['RENT_MANAGER_USERNAME']
#   config.password = ENV['RENT_MANAGER_PASSWORD']
# end

# RentManager.configure do |config|
#   config.company_code = ENV['RENT_MANAGER_COMPANY_CODE']
#   config.auth_token = 'SOME_TOKEN'
# end

auth = {
  rent_manager_company_code: ENV['RENT_MANAGER_COMPANY_CODE'],
  rent_manager_username: ENV['RENT_MANAGER_USERNAME'],
  rent_manager_password: ENV['RENT_MANAGER_PASSWORD']
}

# properties = RentManager::Property.authenticate(auth).embeds(:units, :ownerships).list(page_size: 5, page_number: 1)

# leases = RentManager::Lease.authenticate(auth).embeds('tenant.balance', 'tenant.security_deposit_held').list
# lease = RentManager::Lease.authenticate(auth).find(3)

# owners = RentManager::Owner.list(page_size: 2, page_number: 3)
# owner = RentManager::Owner.find(192)
# owner = RentManager::Owner.authenticate(auth).find(192)

# properties = RentManager::Property.list
# property = RentManager::Property.find(1)

# tenants = RentManager::Tenant.authenticate(auth).embeds(:recurring_charges).list(page_size: 5, page_number: 1)
# tenant = RentManager::Tenant.find(9)

# properties1 = RentManager::Property.id(17).join(:current_owners).list
# properties2 = RentManager::Property.embeds(:ownerships).list
# properties3 = RentManager::Property.filter('Name,ct,House').list
# properties4 = RentManager::Property.id(17).join(:units).list

# RentManager::Property.authenticate(auth).list
# RentManager::Property.authenticate(auth).id(2).join(:current_owners).list

# gl_accounts = RentManager::GeneralLedgerAccount.authenticate(auth).embeds(:parent_gl_account).filter('IsActive,eq,true').list(page_size: 5, page_number: 1)
# gl_account_data = RentManager::GeneralLedgerAccountData.authenticate(auth).list(page_size: 5, page_number: 1)

# charge_types = RentManager::ChargeType.authenticate(auth)
#                                       .filter('IsActive,eq,true')
#                                       .filter('name,eq,RC')
#                                       .list(page_size: 500, page_number: 1)

# /Charges?filters=TransactionDate,ge,01%2F01%2F2020


# charges = RentManager::Charge.authenticate(auth)
#                              .filter('TransactionDate,ge,01/01/2022')
#                              .list(page_size: 500, page_number: 1)
# payments = RentManager::Payment.authenticate(auth)
#                                .embeds(:allocations)
#                                .filter('TransactionDate,ge,01/01/2022')
#                                .list(page_size: 500, page_number: 1)

# gl_report = RentManager::GeneralLedgerReport.authenticate(auth)
#                                             .parameters('StartDate,01/02/2020')
#                                             .parameters('EndDate,01/05/2020')
#                                             .process


# jt_report = RentManager::JournalTransactionReport.authenticate(auth)
#                                             .parameters('StartDate,01/02/2020')
#                                             .parameters('EndDate,02/01/2020')
#                                             .process

tenants = RentManager::Tenant.authenticate(auth)
                             .embeds(:balance, :leases, :recurring_charges, :security_deposit_held)
                             .filter('Status,eq,Current')
                             .list(page_size: 100, page_number: 3)

binding.pry
asdf=3
