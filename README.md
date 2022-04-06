# TsSchema

Uses ActiveRecord to generate a schema.d.ts file for use in typescript frontends.

## Installation

```ruby
bundle add "ts_schema"
```

Then generate the initializer file:

```ruby
rails generate ts_schema:install
```

## Usage

All options with their defaults are in the generated initializer file.

By default, every migration will auto generate a new schema file, replacing the existing one. You can disable this behavior in the config file.

You can manually generate the schema file by running:

```ruby
rails ts_schema:generate
```

## Gotchas

Sometimes ActiveRecord's inflections will alter the class name. For instance, with a class named `Five`; `"Fives".singularize` returns "Fife", which is not the classname. In the case where Rails alters the classname for an association, you must explicitly define it on the association in the model using `class_name`. Example: `has_many :fives, class_name: "Five"`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
