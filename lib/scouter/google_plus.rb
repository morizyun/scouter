module Scouter
  class GooglePlus < Scouter::Base::SingleUrlApi
    API_KEY = 'AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ'.freeze

    private

    # Get and parse response
    # @param [String] url
    # @return [Hash, String] URL & count hash, Error message
    def self.get_and_parse_response(url)
      json  = get_response(url)
      res   = parse_response(json, url)
      return [res, nil]
    rescue => e
      message = "#{e.message}, url: #{url}"
      return [nil, message]
    end

    # Get json data from API
    # @param [String] url
    # @return [String] response from API
    def self.get_response(url)
      option = {'Content-Type' => 'application/json'}
      request = Net::HTTP::Post.new(api_uri.request_uri, option)
      request.body = [{
                          jsonrpc: '2.0',
                          method: 'pos.plusones.get',
                          apiVersion: 'v1',
                          key: 'p',
                          id: 'p',
                          params: {
                              id: url,
                              userId: '@viewer',
                              groupId: '@self',
                              nolog: true,
                          }
                      }].to_json

      Net::HTTP.start(api_uri.host, api_uri.port, :use_ssl => true) { |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.request(request)
      }.body
    end

    # Build url for API
    # @return [URI] URI object of API URL
    def self.api_uri
      URI.parse("https://clients6.google.com/rpc?key=#{API_KEY}")
    end

    # Parse Json data of response
    # @param [Array] json_list
    # @param [String] url
    # @return [Hash] url & count
    def self.parse_response(json_list, url)
      results = {}

      json_list = JSON.parse(json_list)
      json_list.map do |j|
        count = j['result']['metadata']['globalCounts']['count'].to_i
        results[url] = { self.service_name => count }
      end

      results
    end

  end
end
