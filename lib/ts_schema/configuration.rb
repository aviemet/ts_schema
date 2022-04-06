require "pathname"

module TsSchema
  class Configuration
    DEFAULTS = {
      case: :camel,
      output: -> { Rails.root.join('app', 'assets', 'javascripts', 'schema.d.ts') },
      auto_generate: true,
      types: ->{ YAML.load_file(File.expand_path(__dir__) + '/conversion_table.yml').to_h },
      custom_types: {},
      default_type: :string,
      include_associated: true,
      namespace: :schema,
			schema_type: :interface,
      indent: :tab,
      spaces: 2,
			parent_classes: ["ApplicationRecord"],
			additional_models: []
    }

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
      if attributes
        attributes.each do |attribute, value|
          value = value.call if value.is_a?(Proc)
          send(:"#{attribute}=", value)
        end
      end
      self
    end
  end
end
