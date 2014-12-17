module Scouter
  module Base
    module Connection
      # get response by url
      # @param [String] url url which returns json
      # @return [String] object by http request
      def get_response(url)
        open(url).read
      end
    end
  end
end
