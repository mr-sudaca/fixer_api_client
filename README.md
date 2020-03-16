# FixerApiClient

- Just a gem to interact with *Fixer IO API*

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fixer_api_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fixer_api_client

## Usage

- This gem will make currency conversions using [Fixer IO API](https://fixer.io).

- You need to add `FIXER_IO_API_KEY` and `FIXER_IO_API_URL` env vars. You can get api key [here](https://fixer.io/product). The api key is necesssary to update rates on a daily basis
- NOTE: I made this based this with a free account, so no https available for me, that's why you can pass the api url as an env var.

- The gem will inject methods to numeric values, example
```ruby
>> 1.usd
=> 1 United States Dollar
```

- You can also make conversions on the fly:
```ruby
>> 2.usd.to_cop
=> 8253.28 Colombian Peso
```

- If you want to look at available conversion methods
```ruby
FixerApiClient::available_conversions
```

- Or the available currencies
```ruby
FixerApiClient::available_currencies
```

- And if you want to check when the rates data was updated...
```ruby
FixerApiClient::rates_creation_date
```

## TODO

- Update rates on demand
- More tests...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mr-sudaca/fixer_api_client.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
