module Exchanges
  class Client
    module Exchange
      def exchange(*args)
        id = args.first || 'self'
        response = get("exchanges/#{id}")
      end
    end
  end
end
