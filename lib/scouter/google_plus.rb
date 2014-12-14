module Scouter
  class GooglePlus < Scouter::Base::Object
    API_KEY = 'AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ'.freeze

    # get Google Plus Count
    # @param [String or Array] urls
    def self.get_count(urls)
      urls = check_and_trans_url(urls)
      results, errors = {}, []
      urls.each_with_index do |u, idx|
        sleep(WAIT_SEC) if idx != 0
        res, error = get_and_parse_response(u)
        errors << error && next if error
        results.merge!(res)
      end
      res_hash = Hashie::Mash.new(results)
      return [res_hash, errors]
    end

    private

    # Get and parse response
    # @return [String] urls URL list
    # @return [String] service name
    def self.get_and_parse_response(url)
      json  = get_response(url)
      res   = parse_response(json)
      return [res, nil]
    rescue => e
      message = "#{e.message}, url: #{url}"
      return [nil, message]
    end

    # get json data from API
    # @param [String] url
    # @return [Hash] response from API
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

    # Build url for api
    # @param [Hash] json
    # @return [String] API url
    def self.api_uri
      URI.parse("https://clients6.google.com/rpc?key=#{API_KEY}")
    end

    # Parse json data of response
    # @param [Hash] response
    # @return [Hash] url & count
    def self.parse_response(json_list)
      results = {}

      json_list = JSON.parse(json_list)
      json_list.map do |j|
        url = j['result']['id']
        count = j['result']['metadata']['globalCounts']['count'].to_i
        results[url] = { self.service_name => count }
      end

      results
    end

  end
end
