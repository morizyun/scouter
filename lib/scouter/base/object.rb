require_relative 'connection'

module Scouter
  module Base
    class Object
      extend Scouter::Base::Connection

      private

      # Get service name
      # @return [String] service name
      def self.service_name
        self.name.to_s.downcase.gsub(/^(.*::)/, '')
      end

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

    end
  end
end
