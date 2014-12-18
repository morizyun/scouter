module Scouter
  class Buffer < Scouter::Base::SingleUrlApi
    END_POINT = 'https://api.bufferapp.com/1'.freeze

    private

    # Build Feedly API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      "#{END_POINT}/links/shares.json?url=#{url}"
    end

    # Parse json data for response
    # @param [String] json
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      { url => { self.service_name => res['shares'] } }
    end
  end
end
