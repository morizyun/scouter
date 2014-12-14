module Scouter
  class Pinterest < Scouter::Base::Object
    END_POINT = 'http://api.pinterest.com/v1'.freeze

    # get Pinterest Count
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

    # Build url for api
    # @param [Hash] json
    # @return [String] API url
    def self.api_url(url)
      "#{END_POINT}/urls/count.json?url=#{url}"
    end

    # Parse json data for response
    # @param [Hash] json
    # @return [Hash] url & count
    def self.parse_response(json)
      res = JSON.parse(json.gsub(/(receiveCount\(|\))/, ''))
      { res['url'] => { self.service_name => res['count'] } }
    end
  end
end

