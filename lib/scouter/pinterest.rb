module Scouter
  class Pinterest < Scouter::Base::SingleUrlApi
    END_POINT = 'http://api.pinterest.com/v1'.freeze

    private

    # Build url for API
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      "#{END_POINT}/urls/count.json?url=#{url}"
    end

    # Parse JSON data for response
    # @param [String] json
    # @param [String] url
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json.gsub(/(receiveCount\(|\))/, ''))
      { url => { self.service_name => res['count'] } }
    end
  end
end

