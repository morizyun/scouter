require_relative 'connection'

module Scouter
  module Base
    class SingleUrlApi < Scouter::Base::Object

      # Get Count
      # @param [String or Array] urls
      # @return [Hashie::Mash, Array] URL & count hash, Error
      def self.get_count(urls)
        results, errors = {}, []

        # check valid url or change URL to Array object
        urls = check_and_trans_url(urls)

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
      # @param [String] url URL list
      # @return [Hash, String] URL & count hash, Error message
      def self.get_and_parse_response(url)
        response  = get_response(api_url(url))
        result    = parse_response(response, url)
        return [result, nil]
      rescue => e
        message = "#{e.message}, url: #{url}"
        return [nil, message]
      end

    end
  end
end
