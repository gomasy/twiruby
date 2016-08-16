# TwiRuby
[![Build Status](https://img.shields.io/travis/Gomasy/twiruby.svg?style=flat)](https://travis-ci.org/Gomasy/twiruby)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/Gomasy/twiruby.svg?style=flat)](https://codeclimate.com/github/Gomasy/twiruby)
[![Code Climate](https://img.shields.io/codeclimate/github/Gomasy/twiruby.svg?style=flat)](https://codeclimate.com/github/Gomasy/twiruby)

A simple twitter library.  
**[WARNING!!] This gem is in the process of being developed. There may be a destructive change.**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twiruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twiruby

## Example for status/update in oob

```ruby
require "twiruby"

consumer = {
  :consumer_key => "CONSUMER_KEY",
  :consumer_secret => "CONSUMER_SECRET"
}
oauth = TwiRuby::OAuth.new(consumer)

# Get the request token
token = oauth.get_request_token
puts token[:authorize_url]

# Get the access token
token = oauth.get_access_token(token, :oauth_verifier => gets.to_i)

# Let's Tweet!
client = TwiRuby::REST::Client.new(token)
client.update("Test tweet!")
```

## Contributing

1. Fork it ( https://github.com/Gomasy/twiruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
