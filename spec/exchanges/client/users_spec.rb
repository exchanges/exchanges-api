require 'helper'

module Exchanges
  describe Client do
    Configuration::VALID_FORMATS.each do |format|
      describe ".new(:format => '#{format}')" do
        before do
          @client = Client.new(format: format, token: 'secret')
        end

        # describe ".user" do
        #
        #   describe "with user ID passed" do
        #
        #     let(:id) { 'pandd' }
        #
        #     before do
        #       @get = stub_get("users/#{id}.#{format}").
        #         with(:query => {:token => @client.token}).
        #         to_return(:body => fixture("#{id}.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
        #     end
        #
        #     it "should get the correct resource" do
        #       skip
        #       @client.user(id)
        #       assert_requested @get
        #     end
        #
        #     it "should return extended information of a given user" do
        #       skip
        #       user = @client.user(id)
        #       user.full_name.must_equal "Denis Drachev"
        #     end
        #
        #   end
        #
        # end

        describe ".feed" do

          before do
            @get = stub_get("feed.#{format}").
              with(query: {token: @client.token}).
              to_return(:body => fixture("feed.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.feed
            assert_requested @get
          end

          describe Response do
            let(:user_feed_response){ @client.feed }

            subject { user_feed_response }

            it { subject.must_be_kind_of Response }
            it { subject.must_respond_to(:pagination) }
            it { subject.must_respond_to(:meta) }

            describe '.exchanges' do
              subject { user_feed_response.exchanges }

              it { subject.must_be_instance_of Array }
              it { subject.count.must_equal 3 }
            end

            describe '.meta' do
              subject { user_feed_response.meta }

              it { subject.must_be_instance_of Hashie::Mash }
              it { subject.page.must_equal 1 }
            end
          end
        end
      end
    end
  end
end
