# frozen_string_literal: true

require "pathname"

module TsSchema
  class Configuration
    DEFAULTS = {
      case: :camel,
      output: -> { Rails.root.join('app', 'assets', 'javascripts', 'schema.d.ts') },
      auto_generate: true,
      types: ->{ YAML.load_file("#{File.expand_path(__dir__)}/conversion_table.yml").to_h },
      custom_types: {},
      export_nulls: false,
      default_type: :string,
      include_associated: true,
      parent_classes: ["ApplicationRecord"],
      additional_models: [],
      field_overrides: {
        "encrypted_password" => :password,
        "password" => :optional,
      },
      field_type_overrides: {},
      namespace: :schema,
      schema_type: :interface,
      indent: :tab,
      spaces: 2,
    }.freeze

    attr_accessor(*DEFAULTS.keys)

    def initialize(attributes = nil)
      assign(DEFAULTS)
      return unless attributes

      assign(attributes)
    end

    def assign(attributes = nil, &block)
      if !attributes && !block
        raise "Provide attributes or block"
      end

      tap(&block) if block
      attributes&.each do |attribute, value|
        value = value.call if value.is_a?(Proc)
        send(:"#{attribute}=", value)
      end
      self
    end
  end
end
