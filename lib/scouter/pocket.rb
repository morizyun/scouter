module Scouter
  class Pocket < Scouter::Base::Object
    END_POINT = 'https://widgets.getpocket.com'.freeze

    # Get Pocket Count
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

    # Set API parameter for test mock
    # @param [String or Array] num
    def self.set_api_random(num)
      @@api_rand_num = num
    end

    private

    # Get and parse response data
    # @param [String] url URL
    # @return [Hash, String] URL & count hash, Error message
    def self.get_and_parse_response(url)
      html  = get_response(api_url(url))
      res   = parse_response(html, url)
      return [res, nil]
    rescue => e
      message = "#{e.message}, url: #{url}"
      return [nil, message]
    end

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
