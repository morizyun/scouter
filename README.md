# Scouter

Get share count in Buffer/Facebook/Feedly/GooglePlus/HatenaBookmark/Linkedin/Pinterest/Pocket/Twitter

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

	require 'scouter'

	results, errors = SocialCounter.new('http://google.com')
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
	
if you want to get social count in facebook & twitter

	results, errors = SocialCounter.new('http://google.com', [Scouter::Facebook, Scouter::Twitter])
	results.each do |url, service|
	  puts url #=> http://google.com
	  puts service.facebook         #=> 166458
      puts service.twitter          #=> 1358112
	end

## Contributing

1. Fork it ( https://github.com/[my-github-username]/scouter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
