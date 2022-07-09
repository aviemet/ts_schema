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

### Default type mappings

|Ruby Type|Typescript Type|
|:---|:---|
|string|string|
|text|string|
|integer|number|
|enum|number|
|bigint|number|
|float|number|
|decimal|number|
|json|Record<string, any>|
|jsonb|Record<string, any>|
|binary|string|
|boolean|boolean|
|date|string|
|datetime|string|
|timestamp|string|
|datetime_with_timezone|string|
|inet|string|
|cidr|string|
|macaddr|string|

### Initializer options

|Option|Default|Values|Description|
|---|---|---|---|
|case              |`:camel`|`:camel`<br/>`:snake`<br/>`:pascal`|camelCase<br/>snake_case<br/>PascalCase|
|output            |`Rails.root.join('app', 'assets', 'javascripts', 'schema.d.ts')`|Any path|Path to output generated file|
|auto_generate     |`true`|`boolean`|Whether to automatically (re)generate the defenitions after running migrations|
|custom_types      |`{}`|`{ ruby_type: 'typescriptType' }`|Use to add or override type mappings for any type|
|default_type      |`:string`|Any typescript type|The default output type to use if a ruby type is not included in the type mappings|
|include_associated|`true`|`boolean`|Whether to include associated models as fields on the generated interfaces|
|parent_classes    |`["ApplicationRecord"]`|Array of string names of top level classes|Any class names included in this array will be querried for subclasses to generate types for|
|additional_models |`[]`|Array of string names of ActiveRecord models|Add model names which don't inherit from classes included in `parent_classes`, but which should have types generated|
|field_overrides   |`{ encrypted_password: :password,  password: :optional, }`|Hash of field names with the following values:<br/> `:optional`: Makes it an optional field by adding '?' to the defintion (example: password?: string)<br/>`:omit`: Omits the field from being output in the schema entirely<br/>`[string]`: Field name override. Will replace any instance of the hash key with the value. The default values replace `password` with `encrypted_password`|Overwrite, omit, or make optional any field name. Applies to all generated classes|
|namespace         |`:schema`|string\|symbol|The typescript namespace to contain generated types|
|schema_type       |`:interface`|`:interface`\|`:type`|Whether to generate typescript definitions as types or interfaces. Interfaces are recommended since they are easier to extend|
|indent|`:tab`|`:tab`\|`:space`|Indentation using tabs or spaces|
|spaces|`2`|number|Number of spaces for indentation if indentation is set to spaces|


## Gotchas

Sometimes ActiveRecord's inflections will alter the class name. For instance, with a class named `Five`; `"Fives".singularize` returns "Fife", which is not the classname. In the case where Rails alters the classname for an association, you must explicitly define it on the association in the model using `class_name`. Example: `has_many :fives, class_name: "Five"`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
