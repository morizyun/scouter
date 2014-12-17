module Scouter
  class Twitter < Scouter::Base::Object
    END_POINT = 'http://urls.api.twitter.com'.freeze

    # Get Twitter Count
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
