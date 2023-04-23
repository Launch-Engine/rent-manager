require 'pry-byebug'
require './lib/rent_manager'

RentManager.configure do |config|
  config.company_code = ENV['RENT_MANAGER_COMPANY_CODE']
  config.username = ENV['RENT_MANAGER_USERNAME']
  config.password = ENV['RENT_MANAGER_PASSWORD']
end

# RentManager.configure do |config|
#   config.company_code = ENV['RENT_MANAGER_COMPANY_CODE']
#   config.auth_token = 'SOME_TOKEN'
# end

# auth = {
#   rent_manager_company_code: ENV['RENT_MANAGER_COMPANY_CODE'],
#   rent_manager_username: ENV['RENT_MANAGER_USERNAME'],
#   rent_manager_password: ENV['RENT_MANAGER_PASSWORD']
# }

leases = RentManager::Lease.list
lease = RentManager::Lease.find(3)

owners = RentManager::Owner.list(page_size: 2, page_number: 3)
owner = RentManager::Owner.find(192)

properties = RentManager::Property.list
property = RentManager::Property.find(1)

tenants = RentManager::Tenant.list
tenant = RentManager::Tenant.find(9)

properties1 = RentManager::Property.join(:current_owners).list
properties2 = RentManager::Property.embeds(:ownerships).list
properties3 = RentManager::Property.filter('Name,ct,House').list
properties4 = RentManager::Property.id(17).join(:units).list

binding.pry

asdf=3
