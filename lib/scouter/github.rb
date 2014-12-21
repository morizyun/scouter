module Scouter
  class Github < Scouter::Base::SingleUrlApi
    END_POINT = 'https://api.github.com'.freeze

    private

    def self.check_and_trans_url(urls)
      urls = to_array(urls)

      github_urls = urls.map do |u|
        uri = URI.parse(u)
        uri.host == 'github.com' ? u : nil
      end.compact

      raise ArgumentError, "#{github_urls} is not String and Array" unless github_urls.class == Array
      return github_urls
    end

    # Build GitHub API URL
    # @param [String] url
    # @return [String] API url
    def self.api_url(url)
      uri = URI.parse(url)
      if uri.path =~ /^\/([^\/]+)\/([^\/]+)/
        "#{END_POINT}/repos/#{$1}/#{$2}"
      else
        raise ArgumentError, "#{url} is not valid GitHub URL"
      end
    end

    # Parse json data for response
    # @param [String] json
    # @return [Hash] url & count
    def self.parse_response(json, url)
      res = JSON.parse(json)
      { url => { self.service_name => res['stargazers_count'] } }
    end
  end
end
