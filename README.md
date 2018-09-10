# NullAssociations

[![Build Status](https://travis-ci.org/wohlgejm/null_associations.svg?branch=master)](https://travis-ci.org/wohlgejm/null_associations)
[![Maintainability](https://api.codeclimate.com/v1/badges/f44896d46cac05f9e470/maintainability)](https://codeclimate.com/github/wohlgejm/null_associations/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f44896d46cac05f9e470/test_coverage)](https://codeclimate.com/github/wohlgejm/null_associations/test_coverage)

Return null objects for your Rails `belongs_to` and `has_one` associations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'null_associations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install null_associations

## Usage

Supply a new option with your `has_one` or `belongs_to` declarations.

```ruby
class NullDuck
  def quack
    ''
  end
end

class Duck < ApplicationRecord
  def quack
    'quack! quack!'
  end
end

class Duckling < ApplicationRecord
  belongs_to :duck, null_object: NullDuck
end

duck = Duckling.create!(duck: nil)
duckling.duck.quack
=> ""
```

These can become even more powerful with `ActiveRecord::QueryMethods.none`.

```ruby
class NullDuck
  def ducklings
    Duck.none
  end

  def quack
    ''
  end
end

class Duck < ApplicationRecord
  has_many :ducklings

  def quack
    'quack! quack!'
  end
end

class Duckling < ApplicationRecord
  scope :brown, -> { where(brown: true) }
  belongs_to :duck, null_object: NullDuck
end

duck = Duckling.create!(duck: nil)
duckling.duck.ducklings.brown.where('created_at > ?', 2.days.ago)
=> []
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wohlgejm/null_associations. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NullAssociations project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/null_associations/blob/master/CODE_OF_CONDUCT.md).
