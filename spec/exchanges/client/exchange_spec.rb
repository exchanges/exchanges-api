require 'helper'

module Exchanges
  describe Client do
    Configuration::VALID_FORMATS.each do |format|
      describe ".new(format: '#{format}')" do
        before do
          @client = Client.new(format: format, token: 'token')
        end

        describe ".exchange" do

          let(:id) { 'ex_permalink' }

          before do
            @stubbed_get = stub_get("exchanges/#{id}.#{format}").
            with(query: {token: @client.token}).
            to_return(body: fixture("exchange.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.exchange(id)
            assert_requested @stubbed_get
          end

          it "should return extended information of a given item" do
            response = @client.exchange(id)
            response.exchange.user.full_name.must_equal "Denis Drachev"
          end
        end

      end
    end
  end
end
