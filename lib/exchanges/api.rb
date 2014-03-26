require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)
require File.expand_path('../response', __FILE__)

module Exchanges
  class Api
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = Exchanges.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Connection
    include Request
  end
end
