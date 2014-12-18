module Scouter
  class Twitter < Scouter::Base::SingleUrlApi
    END_POINT = 'http://urls.api.twitter.com'.freeze

    private

    # Build Twitter API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      escaped_url = URI.escape(url)
      "#{END_POINT}/1/urls/count.json?url=#{escaped_url}"
    end

    # Parse JSON data for response
    # @param [String] json data
    # @param [String] url
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      { url => { self.service_name => res['count'] } }
    end
  end
end
