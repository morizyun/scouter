module Scouter
  class Linkedin < Scouter::Base::SingleUrlApi
    END_POINT = 'https://www.linkedin.com/countserv'.freeze

    private

    # Build url for API
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      "#{END_POINT}/count/share?url=#{url}&format=json"
    end

    # Parse JSON data for response
    # @param [String] json
    # @param [String] url
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      { url => { self.service_name => res['count'] } }
    end
  end
end

