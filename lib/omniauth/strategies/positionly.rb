require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Positionly < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = "read"

      option :name, 'positionly'
      option :authorize_options, [:scope, :account_fingerprint]

      option :client_options, {
        :site          => 'https://api.positionly.com',
        :authorize_url => '/oauth2/authorize',
        :token_url     => '/oauth2/token'
      }

      def authorize_params
        super.tap do |params|
          %w(scope account_fingerprint).each do |k|
            params[k.to_sym] = request.params[k] unless [nil, ''].include?(request.params[k])
          end
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      uid { raw_info['id'] }

      info do
        raw_info
      end

      extra do
        hash = {}
        hash[:raw_info] = raw_info unless skip_info?
        hash
      end

      def raw_info
        @raw_info ||= access_token.get("/v1/addons/user.json").parsed
      end
    end
  end
end
