module Scouter
  class Feedly < Scouter::Base::Object
    END_POINT = 'http://cloud.feedly.com/v3'.freeze

    # get Feedly Count
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

    # build Feedly API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      escaped_url = CGI.escape(url)
      "#{END_POINT}/feeds/feed%2F#{escaped_url}"
    end

    # Parse json data for response
    # @param [Hash] json
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      return {} if res.empty?
      { url => { self.service_name => res['subscribers'] } }
    end
  end
end
