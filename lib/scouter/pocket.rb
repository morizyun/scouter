module Scouter
  class Pocket < Scouter::Base::SingleUrlApi
    END_POINT = 'https://widgets.getpocket.com'.freeze

    # Set API parameter for test mock
    # @param [String or Array] num
    def self.set_api_random(num)
      @@api_rand_num = num
    end

    private

    # Build Pocket API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      esc_url = URI.escape(url)
      rand_num = @@api_rand_num || rand(100000000)
      "#{END_POINT}/v1/button?label=pocket&count=vertical&align=left&v=1&url=#{esc_url}&title=&src=#{esc_url}&r=#{rand_num}"
    end

    # Parse html for response
    # @param [String] html
    # @param [String] url
    # @return [Hash] url & count
    def self.parse_response(html, url)
      count = (html.to_s =~ /id="cnt"[^0-9]+([0-9]+)/) ? $1.to_i : 0
      { url => { self.service_name => count } }
    end
  end
end
