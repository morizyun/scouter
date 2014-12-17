module Scouter
  class Buffer < Scouter::Base::Object
    END_POINT = 'https://api.bufferapp.com/1'.freeze

    # Get Buffer Share Count
    # @param [String or Array] urls
    # @return [Hashie::Mash, Array] URL & count hash, Error
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

    # Get and parse response data & error message
    # @param [String] urls URL list
    # @return [Hash, String] URL & count hash, Error message
    def self.get_and_parse_response(url)
      html  = get_response(api_url(url))
      res   = parse_response(html, url)
      return [res, nil]
    rescue => e
      message = "#{e.message}, url: #{url}"
      return [nil, message]
    end

    # Build Feedly API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      "#{END_POINT}/links/shares.json?url=#{url}"
    end

    # Parse json data for response
    # @param [String] json
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      { url => { self.service_name => res['shares'] } }
    end
  end
end
