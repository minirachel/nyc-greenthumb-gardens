# NycGreenthumbGardens

An app to learn about the GreenThumb gardens in New York City.

Current Features:
- Filter by borough
- Filter by ZIP code
- Run "reports" of park names and their ID numbers
- Run "report" of most populated zipcodes by borough or overall city
- Randomly pull one up a park to learn more
- Search by park name or ID number
- Data pulled from the City of New York's NYC Open Data API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nyc_greenthumb_gardens'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nyc-greenthumb-gardens

## How to Start

Run `bin/run.rb` in your console for an interactive CLI menu.

## Development

After checking out the repo, run `bundle install` to install dependencies. You can also run `bin/run.rb` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/minirachel/nyc-greenthumb-gardens. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/minirachel/nyc-greenthumb-gardens/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NycGreenthumbGardens project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/minirachel/nyc-greenthumb-gardens/blob/master/CODE_OF_CONDUCT.md).

## Land Acknowledgement

We (the app creators and users) acknowledge that the land used for these gardens are on the unceded land of the Lenape and Canarsie peoples. We acknowledge the Lenape and Canarsie communities, their elders both past and present, as well as future generations. This acknowledgement demonstrates a commitment to beginning the process of working to dismantle the ongoing legacies of settler colonialism.
