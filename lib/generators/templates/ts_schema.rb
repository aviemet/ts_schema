TsSchema.setup do |config|
  # Options: camel|snake|pascal
  # config.case = :camel

  # Customize output path and file name
  # config.output = Rails.root.join('app', 'assets', 'javascripts', 'schema.d.ts')

  # Whether to generate the schema file on migrations and rollbacks
  # config.auto_generate = true

  # Add custom type mappings or overrides
	#
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
	#
  # config.custom_types = {
  #   
  # }

  # Default type for unrecognized types
  # config.default_type = :string

  # Whether to generate types for associations
  # config.include_associated = true

	# Additional models to map which don't have a model file
	# config.additional_models = [
	#	
	# ]

  # Namespace
  # config.namespace = :schema

  # Options: tab|space
  # config.indent = :tab

  # If indent is spaces, specify how many
  # config.spaces = 2
end
