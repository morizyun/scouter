# coding:utf-8
# Standard Library
require 'cgi'
require 'open-uri'
require 'json'
require 'hashie/mash'
require 'parallel'

# Scouter Class/Module
require 'scouter/base/version'
require 'scouter/base/object'
require 'scouter/buffer'
require 'scouter/facebook'
require 'scouter/feedly'
require 'scouter/google_plus'
require 'scouter/hatena_bookmark'
require 'scouter/linkedin'
require 'scouter/pinterest'
require 'scouter/pocket'
require 'scouter/twitter'

module Scouter
  WAIT_SEC = 1
  ONE_TIME_URL_MAX = 20

  SERVICES = [ Scouter::Buffer,
               Scouter::Facebook,
               Scouter::Feedly,
               Scouter::GooglePlus,
               Scouter::HatenaBookmark,
               Scouter::Linkedin,
               Scouter::Pinterest,
               Scouter::Pocket,
               Scouter::Twitter ]

  # Get Social Count By Buffer/Facebook/Feedly/GooglePlus/HatenaBookmark/Linkedin/Pinterest/Pocket/Twitter
  # @param [String or Array] urls url list ot get count
  # @param [Array or nil] service service list to get count
  # @return [Hashie::Mash, Hashie::Mash] URL & count hash, Error
  def self.get_count(urls, services = SERVICES)
    results, errors = [], Hashie::Mash.new()

    Parallel.each(services, in_threads: services.count) do |service|
      result, error = service.get_count(urls)
      errors[service.service_name] = error && next unless error.empty?
      results << result
    end

    results_hash = results_merged_hash(results)
    return [results_hash, errors]
  end

  private

  # Merge result data of service to hash
  # @param [Hashie::Mash] social count & url of some services
  # @return [Hashie::Mash] URL & count hash, Error
  def self.results_merged_hash(results)
    results_hash = {}
    results.each do |item|
      item.each do |url, hash|
        results_hash[url] = (results_hash[url] || {}).merge(hash)
      end
    end
    Hashie::Mash.new(results_hash)
  end

end
