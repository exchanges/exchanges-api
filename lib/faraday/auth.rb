require 'faraday'

module FaradayMiddleware
  class ExchangeAuth < Faraday::Middleware
    def call(env)

      if env[:url].query.nil?
        query = {}
      else
        query = Faraday::Utils.parse_query(env[:url].query)
      end

      env[:url].query = Faraday::Utils.build_query(query.merge(:token => @access_token))
      env[:request_headers] = env[:request_headers].merge('Authorization' => "Token token=\"#{@access_token}\"")

      @app.call env
    end

    def initialize(app, client_id, access_token=nil)
      @app = app
      @client_id = client_id
      @access_token = access_token
    end
  end
end
