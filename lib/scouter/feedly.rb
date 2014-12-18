module Scouter
  class Feedly < Scouter::Base::SingleUrlApi
    END_POINT = 'http://cloud.feedly.com/v3'.freeze

    private

    # Build Feedly API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      escaped_url = CGI.escape(url)
      "#{END_POINT}/feeds/feed%2F#{escaped_url}"
    end

    # Parse json data for response
    # @param [String] json response by API
    # @param [String] url
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      return {} if res.empty?
      { url => { self.service_name => res['subscribers'] } }
    end
  end
end
