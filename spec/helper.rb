require 'exchanges'
require "minitest/autorun"
require "minitest/spec"
require 'webmock/minitest'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def a_delete(path)
  a_request(:delete, Exchanges.endpoint + path)
end

def a_get(path)
  a_request(:get, Exchanges.endpoint + path)
end

def a_post(path)
  a_request(:post, Exchanges.endpoint + path)
end

def a_put(path)
  a_request(:put, Exchanges.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, Exchanges.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Exchanges.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Exchanges.endpoint + path)
end

def stub_put(path)
  stub_request(:put, Exchanges.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
