module Scouter
  class HatenaBookmark < Scouter::Base::Object
    END_POINT = 'http://api.b.st-hatena.com'.freeze

    private

    # Build Hatena Bookmark Count API URL
    # @param [Array] url
    # @return [String] API url
    def self.api_url(url)
      url_str = url.map{ |u| "url=#{URI.escape(u)}" }.join('&')
      "#{END_POINT}/entry.counts?#{url_str}"
    end

    # Parse JSON data of response
    # @param [String] response
    # @return [Hash] url & count
    def self.parse_response(response, urls = nil)
      parse_response_item(JSON.parse(response))
    end

    # Parse JSON list data of response
    # @param [Array] response
    # @return [Hash] url & count
    def self.parse_response_item(json_list)
      results = {}
      json_list.each do |json|
        url = json[0]
        results[url] = { self.service_name => json[1] }
      end
      results
    end
  end
end
