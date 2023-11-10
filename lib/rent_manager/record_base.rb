module RentManager
  class RecordBase
    SUCCESS_CODES = [200, 201, 204].freeze

    class << self
      # -------- Action Methods --------
      # def create(params)
      # end

      def fetch_id(path, id, params = {})
        response = process_request(:get, [path, id].join('/'), params)
        return RentManager::RentManagerResult.new(response) if SUCCESS_CODES.include?(response.response_code)

        RentManager::RentManagerError.new(response)
      end

      def fetch(path, params)
        response = process_request(:get, path, params)
        return RentManager::RentManagerResultSet.new(response) if SUCCESS_CODES.include?(response.response_code)

        RentManager::RentManagerError.new(response)
      end

      def fetch_report(path, params)
        response = process_request(:get, path, params)
        return RentManager::RentManagerResultReport.new(response) if SUCCESS_CODES.include?(response.response_code)

        RentManager::RentManagerError.new(response)
      end

      # def update(id, params)
      # end

      # -------- Process Methods --------

      def extract_auth(params)
        company_code = params&.delete(:rent_manager_company_code) || RentManager.configuration&.company_code
        auth_token = params&.delete(:rent_manager_auth_token) || RentManager.configuration&.auth_token
        partner_token = params&.delete(:rent_manager_partner_token) || RentManager.configuration&.partner_token

        if auth_token.nil? && partner_token.nil?
          username = params&.delete(:rent_manager_username) || RentManager.configuration&.username
          password = params&.delete(:rent_manager_password) || RentManager.configuration&.password
          auth_token = login(company_code, username, password)
        end

        retval = { rent_manager_company_code: company_code }
        retval[:rent_manager_partner_token] = partner_token unless partner_token.nil?
        retval[:rent_manager_auth_token] = auth_token unless auth_token.nil?
        retval
      end

      def extract_proxy(params)
        params&.delete(:proxy) || RentManager.configuration&.proxy
      end

      def login(company_code, username, password)
        raise 'Company code for Rent Manager is not set.' if company_code.nil?
        raise 'Username for Rent Manager is not set.' if username.nil?
        raise 'Password for Rent Manager is not set.' if password.nil?

        http_response = Typhoeus::Request.new(
          "https://#{company_code}.api.rentmanager.com/Authentication/AuthorizeUser",
          method: :post,
          headers: { 'Content-Type' => 'application/json' },
          body: {
            Username: username,
            Password: password,
            LocationID: 1
          }.to_json
        ).run

        # The response for the token is a quoted string, so we need to remove the quotes.
        return http_response.body.gsub(/"/, '') if SUCCESS_CODES.include?(http_response.response_code)

        JSON.parse(http_response.body, symbolize_names: true).to_snake_keys[:developer_message]
      end

      def process_request(request_type, url_path, params = {})
        auth = extract_auth(params)
        proxy = extract_proxy(params)

        request_params = {
          method: request_type,
          params: params.to_camelback_keys,
          headers: rent_manager_auth_headers(auth)
        }
        request_params[:proxy] = proxy unless proxy.nil?

        Typhoeus::Request.new(
          "https://#{auth[:rent_manager_company_code]}.api.rentmanager.com/#{url_path}",
          request_params
        ).run
      end

      def rent_manager_auth_headers(auth)
        retval = { 'Content-Type' => 'application/json' }
        retval['X-RM12Api-ApiToken'] = auth[:rent_manager_auth_token] unless auth[:rent_manager_auth_token].nil?
        retval['X-RM12Api-PartnerToken'] = auth[:rent_manager_partner_token] unless auth[:rent_manager_partner_token].nil?
        retval['X-RM12Api-LocationID'] = 1
        retval
      end
    end
  end
end
