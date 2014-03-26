require File.expand_path('../exchanges/configuration', __FILE__)
require File.expand_path('../exchanges/api', __FILE__)
require File.expand_path('../exchanges/client', __FILE__)
require File.expand_path('../exchanges/error', __FILE__)

module Exchanges
  extend Configuration

  def self.client(options={})
    Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
