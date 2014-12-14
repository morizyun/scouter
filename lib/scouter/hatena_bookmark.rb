module Scouter
  class HatenaBookmark < Scouter::Base::Object
    END_POINT = 'http://api.b.st-hatena.com'.freeze

    private

    # build Hatena Bookmark Count API URL
    # @param [Array] url
    # @return [String] API url
    def self.api_url(url)
      url_str = url.map{ |u| "url=#{URI.escape(u)}" }.join('&')
      "#{END_POINT}/entry.counts?#{url_str}"
    end

    # Parse json data of response
    # @param [Hash] response
    # @return [Hash] url & count
    def self.parse_response(response)
      parse_response_item(JSON.parse(response))
    end

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
