require 'helper'

describe Exchanges do
  after do
    Exchanges.reset
  end

  describe "when delegating to a client" do

     before do
       @get = stub_get("feed.json").
         to_return(:body => fixture("feed.json"), :headers => {:content_type => "application/json; charset=utf-8"})
     end

     it "should get the correct resource" do
       Exchanges.feed
       assert_requested @get
     end

     it "should return the same results as a client" do
       Exchanges.feed.must_equal Exchanges::Client.new.feed
     end

  end

  describe ".client" do
    it "should be a Exchange::Client" do
      Exchanges.client.must_be_instance_of Exchanges::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Exchanges.adapter.must_equal Exchanges::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Exchanges.adapter = :typhoeus
      Exchanges.adapter.must_equal :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Exchanges.endpoint.must_equal Exchanges::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Exchanges.endpoint = 'http://tumblr.com'
      Exchanges.endpoint.must_equal 'http://tumblr.com'
    end
  end

  describe ".format" do
    it "should return the default format" do
      Exchanges.format.must_equal Exchanges::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Exchanges.format = 'xml'
      Exchanges.format.must_equal 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Exchanges.user_agent.must_equal Exchanges::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Exchanges.user_agent = 'Custom User Agent'
      Exchanges.user_agent.must_equal 'Custom User Agent'
    end
  end

  describe ".verson" do
    it 'should have a version' do
      Exchanges::VERSION.wont_be_nil
    end
  end

  describe ".configure" do

    Exchanges::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Exchanges.configure do |config|
          config.send("#{key}=", key)
          Exchanges.send(key).must_equal key
        end
      end
    end
  end
end
