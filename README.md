# Scouter [![Gem Version](https://badge.fury.io/rb/scouter.svg)](http://badge.fury.io/rb/scouter) [![Build Status](https://travis-ci.org/morizyun/scouter.svg?branch=master)](https://travis-ci.org/morizyun/scouter) [![Code Climate](https://codeclimate.com/github/morizyun/scouter/badges/gpa.svg)](https://codeclimate.com/github/morizyun/scouter) [![Test Coverage](https://codeclimate.com/github/morizyun/scouter/badges/coverage.svg)](https://codeclimate.com/github/morizyun/scouter) [![endorse](https://api.coderwall.com/morizyun/endorsecount.png)](https://coderwall.com/morizyun)

Get share count in Buffer/Facebook/Feedly/GitHub/GooglePlus/HatenaBookmark/Linkedin/Pinterest/Pocket/Twitter

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scouter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scouter

## Usage Command Line

	scouter -u [page url]

## Usage Ruby Program

```ruby
require 'scouter'

results, errors = Scouter.get_count('http://google.com')
results.each do |url, service|
  puts url #=> http://google.com
  puts service.buffer           #=> 129
  puts service.facebook         #=> 166458
  puts service.googleplus       #=> 139198
  puts service.hatenabookmark   #=> 13466
  puts service.linkedin         #=> 216
  puts service.pinterest        #=> 1
  puts service.twitter          #=> 1358112
end
```

if you want to get social count in facebook & twitter

```ruby
results, errors = Scouter.get_count('http://google.com', [Scouter::Facebook, Scouter::Twitter])
results.each do |url, service|
  puts url #=> http://google.com
  puts service.facebook         #=> 166458
  puts service.twitter          #=> 1358112
end
```

## Correspondence services

    * Scouter::Buffer
    * Scouter::Facebook
    * Scouter::Feedly #=> can get only feed url
    * Scouter::Github #=> can get only github.com repository url
    * Scouter::GooglePlus
    * Scouter::HatenaBookmark
    * Scouter::Linkedin
    * Scouter::Pinterest
    * Scouter::Pocket
    * Scouter::Twitter

## Contributing

1. Fork it ( https://github.com/morizyun/scouter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
