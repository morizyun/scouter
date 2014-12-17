require_relative 'connection'

module Scouter
  module Base
    class Object
      extend Scouter::Base::Connection

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
        res     = parse_response(json, urls)
        return [res, nil]
      rescue => e
        message = "#{e.message}, urls: #{urls}"
        return [nil, message]
      end

      # Get service name
      # @return [String] service name
      def self.service_name
        self.name.to_s.downcase.gsub(/^(.*::)/, '')
      end

      # Check and transform urls to Array
      # @param [String or Array] urls
      # @return [Array] url
      def self.check_and_trans_url(url)
        url = to_array(url)
        raise ArgumentError, "#{url} is not String and Array" unless url.class == Array
        return url
      end

      # Transform Array or String to Array
      # @param [Array or String] item
      # @return [Array or nil]
      def self.to_array(item)
        case item.class.to_s
          when 'Array'
            item
          when 'String'
            [item]
          else
            nil
        end
      end

      # Parse response data for response (For Override)
      # @param [String] response
      # @return [Hash] urls & count
      def self.parse_response(response, url = nil)
      end

      # build API URL (For Override)
      # @param [String] url
      # @return [String] API url
      def self.api_url(url)
      end
    end
  end
end
