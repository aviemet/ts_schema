# Default type mappings:
#
# string:                 string
# text:                   string
# integer:                number
# enum:                   number
# bigint:                 number
# float:                  number
# decimal:                number
# json:                   Record<string, any>
# jsonb:                  Record<string, any>
# binary:                 string
# boolean:                boolean
# date:                   string
# datetime:               string
# timestamp:              string
# datetime_with_timezone: string
# inet:                   string
# cidr:                   string
# macaddr:                string

TsSchema.setup do |config|
  # Case options: camel|snake|pascal
  #
  # config.case = :camel


  # Customize output path and file name
  #
  # config.output = Rails.root.join('app', 'assets', 'javascripts', 'schema.d.ts')


  # Whether to generate the schema file after running migrations
  #
  # config.auto_generate = true


  # Add custom type mappings or overrides
  #
  # config.custom_types = {
  #   
  # }


  # Default type for unrecognized types
  #
  # config.default_type = :string


  # Whether to generate types for associated models
  #
  # config.include_associated = true


  # Parent classes of models to generate (as strings or symbols)
  # Only classes inheriting from those in this list will have types generated
  #
  # config.parent_classes = [
  #	  "ApplicationRecord",
  # ]


  # Additional models to generate schema from, such as those added by other gems 
  #  which don't have a model file. (as strings or symbols)
  #
  # config.additional_models = [
  #	
  # ]


  # Namespace for generated types
  #
  # config.namespace = :schema


  # Output schema as types or interfaces: type|interface
  #
  # config.schema_type = :interface


  # Indentation options: tab|space
  #
  # config.indent = :tab


  # If indent is spaces, specify how many
  #
  # config.spaces = 2
end
