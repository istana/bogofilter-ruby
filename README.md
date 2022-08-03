# Bogofilter

A simple library written in Ruby language to detect spam built around `bogofilter` executable (wrapper).
The supported input format is the same as in bogofilter - text, EML, mbox.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bogofilter'

or

gem 'bogofilter', github: 'istana/bogofilter-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bogofilter

Also `bogofilter` executable is required on the system, run `apt-get install bogofilter` or similar.

## Usage

```ruby
  filter = Bogofilter.new(dbpath: "exampledb")
  #=> #<Bogofilter:0x00007fa9e2999a60 @dbpath="exampledb", @verbosity=0>
  filter.add_spam("test")
  #=> true # adds and also creates the database
  filter.classify("an example of tested text")
  #=> {:result=>:unsure, :score=>0.52}
  filter.is_spam?("an example of tested text")
  #=> nil (nil means unsure result)
```

For more information, see the source code. The same behavior applies to the gem as with pure bogofilter command, i.e. a database needs to be trained to be sure if input is spam or ham.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/istana/bogofilter-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/istana/bogofilter-ruby/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bogofilter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/istana/bogofilter-ruby/blob/master/CODE_OF_CONDUCT.md).
