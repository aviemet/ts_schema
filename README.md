# TsSchema
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "ts_schema"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install ts_schema
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Gotchas

Apparantly, sometimes ActiveRecord's inflections will alter the class name. For instance, with a class named `Five`; `"Fives".singularize` returns "Fife", which is not the classname. In the case where Rails alters the classname for an association, you must explicitly define it on the association in the model using `class_name`. Example: `has_many :fives, class_name: "Five"`.
