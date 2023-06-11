# frozen_string_literal: true

require 'rubygems'
require 'json'
require 'typhoeus'
require 'awrence'
require 'plissken'

require_relative 'rent_manager/version'

require_relative 'rent_manager/rent_manager'

require_relative 'rent_manager/configuration'

require_relative 'rent_manager/rent_manager_error'

require_relative 'rent_manager/rent_manager_result_base'
require_relative 'rent_manager/rent_manager_result'
require_relative 'rent_manager/rent_manager_result_set'

require_relative 'rent_manager/record_base'
require_relative 'rent_manager/rent_manager_relation'

# Models
require_relative 'rent_manager/charge'
require_relative 'rent_manager/charge_type'
require_relative 'rent_manager/general_ledger_account'
require_relative 'rent_manager/general_ledger_account_data'
require_relative 'rent_manager/lease'
require_relative 'rent_manager/tenant'
require_relative 'rent_manager/owner'
require_relative 'rent_manager/payment'
require_relative 'rent_manager/property'
