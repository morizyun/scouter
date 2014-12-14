module Scouter
  class Facebook < Scouter::Base::Object
    END_POINT = 'https://graph.facebook.com'.freeze

    private

    # build Facebook Graph API url
    # @param [Array] url
    # @return [String] API url
    def self.api_url(url)
      str = url.map{ |u| "%27#{URI.escape(u)}%27" }.join(',')
      "#{END_POINT}/fql?q=SELECT%20url,%20total_count%20FROM%20link_stat%20WHERE%20url%20in%20(#{str})"
    end

    # Parse json data of response
    # @param [Hash] json
    # @return [Hash] url & count
    def self.parse_response(json)
      parse_response_item(JSON.parse(json)['data'])
    end

    def self.parse_response_item(json_list)
      results = {}
      json_list.each do |json|
        url = json['url']
        results[url] = { self.service_name => json['total_count'] }
      end
      results
    end
  end
end
