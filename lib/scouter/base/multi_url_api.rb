require_relative 'connection'

module Scouter
  module Base
    class MultiUrlApi < Scouter::Base::Object

      # Get Count By URL
      # @param [String or Array] urls
      # @return [Hashie::Mash, Array] URL & count hash, Error
      def self.get_count(urls)
        urls = check_and_trans_url(urls)
        results, errors = {}, []
        urls.each_slice(ONE_TIME_URL_MAX) do |u|
          res, error = get_and_parse_response(u)
          errors << error && next if error
          results.merge!(res)
        end
        res_hash = Hashie::Mash.new(results)
        return [res_hash, errors]
      end

      private

      # Get response and parse it By URL
      # @param [String or Array] urls
      # @return [Hash, String] URL & count hash, Error message
      def self.get_and_parse_response(urls)
        url_str = api_url(urls)
        json    = get_response(url_str)
        res     = parse_response(json)
        return [res, nil]
      rescue => e
        message = "#{e.message}, urls: #{urls}"
        return [nil, message]
      end

    end
  end
end
