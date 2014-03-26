module Exchanges
  module Response
    def self.create( response_hash )
      data = response_hash.data.dup rescue response_hash.dup
      data.extend( self )
      data.instance_exec do
        @pagination = response_hash.pagination
        @meta = response_hash.meta
      end
      data
    end

    attr_reader :pagination
    attr_reader :meta
  end
end
