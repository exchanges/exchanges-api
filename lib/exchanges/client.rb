module Exchanges
  class Client < Api
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Client::User
    include Client::Exchange
  end
end
