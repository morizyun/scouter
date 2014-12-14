if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
  require 'codeclimate-test-reporter'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      Coveralls::SimpleCov::Formatter,
      CodeClimate::TestReporter::Formatter
  ]
  SimpleCov.start 'test_frameworks'
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scouter'
require 'rspec'
require 'fakeweb'
require 'pry'

def fixture(path)
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

def stub_get(path, fixture_path, options={})
  opts = {
      :body => fixture(fixture_path),
      :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:get, "#{path}", opts)
end

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) do
    # Buffer
    stub_get(Scouter::Buffer.__send__(:api_url, 'http://www.yahoo.co.jp/'), 'scouter/buffer_yahoo.json')
    stub_get(Scouter::Buffer.__send__(:api_url, 'http://www.google.com/'),  'scouter/buffer_google.json')

    # Facebook
    stub_get(Scouter::Facebook.__send__(:api_url, ['http://www.yahoo.co.jp/']),                           'scouter/facebook_yahoo.json')
    stub_get(Scouter::Facebook.__send__(:api_url, ['http://www.yahoo.co.jp/', 'http://www.google.com/']), 'scouter/facebook_yahoo_google.json')

    # Feedly
    Scouter::Pocket.__send__(:set_api_random, 1192296)
    stub_get(Scouter::Feedly.__send__(:api_url, 'http://morizyun.github.io'),                   'scouter/feedly_morizyun_hp.json')
    stub_get(Scouter::Feedly.__send__(:api_url, 'http://feeds.feedburner.com/rubyrails'),       'scouter/feedly_morizyun_feed.json')
    stub_get(Scouter::Feedly.__send__(:api_url, 'http://rss.dailynews.yahoo.co.jp/fc/rss.xml'), 'scouter/feedly_yahoo_news.json')

    # Twitter
    stub_get(Scouter::Twitter.__send__(:api_url, 'http://www.yahoo.co.jp/'),  'scouter/twitter_yahoo.json')
    stub_get(Scouter::Twitter.__send__(:api_url, 'http://www.google.com/'),   'scouter/twitter_google.json')

    # Hatena Bookmark
    stub_get(Scouter::HatenaBookmark.__send__(:api_url, ['http://www.yahoo.co.jp/']),                           'scouter/hatenabookmark_yahoo.json')
    stub_get(Scouter::HatenaBookmark.__send__(:api_url, ['http://www.yahoo.co.jp/', 'http://www.google.com/']), 'scouter/hatenabookmark_yahoo_google.json')

    # LinkedIn
    stub_get(Scouter::Linkedin.__send__(:api_url, 'http://www.yahoo.co.jp/'),  'scouter/linkedin_yahoo.json')
    stub_get(Scouter::Linkedin.__send__(:api_url, 'http://www.google.com/'),   'scouter/linkedin_google.json')

    # Pocket
    Scouter::Pocket.__send__(:set_api_random, 1192296)
    stub_get(Scouter::Pocket.__send__(:api_url, 'http://www.yahoo.co.jp/'),               'scouter/pocket_yahoo.html')
    stub_get(Scouter::Pocket.__send__(:api_url, 'http://www.google.com/'),                'scouter/pocket_google.html')
    stub_get(Scouter::Pocket.__send__(:api_url, 'http://feeds.feedburner.com/rubyrails'), 'scouter/pocket_morizyun_feed.html')
    stub_get(Scouter::Pocket.__send__(:api_url, 'http://morizyun.github.io'),             'scouter/pocket_morizyun_hp.html')

    # Pinterest
    stub_get(Scouter::Pinterest.__send__(:api_url, 'http://www.yahoo.co.jp/'),  'scouter/pinterest_yahoo.json')
    stub_get(Scouter::Pinterest.__send__(:api_url, 'http://www.google.com/'),   'scouter/pinterest_google.json')
  end
end