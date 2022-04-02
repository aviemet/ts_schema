require 'fileutils'

module TsSchema
  class SchemaGenerator
    def initialize
      Rails.application.eager_load!
      @models = ApplicationRecord.send(:subclasses)
			@models << TsSchema.configuration.additional_models unless TsSchema.configuration.additional_models.empty?
      @types = TsSchema.configuration.types.merge(TsSchema.configuration.custom_types || {})
    end

    def generate
      generate_typescript
    end

    def output_file
      path = TsSchema.configuration.output
      FileUtils.mkdir_p(File.dirname(path))

			content = generate
      return if File.exist?(path) && File.read(path) == content

      File.open(path, 'w') do |f|
        f.write content
      end
    end

    private

    def generate_typescript
      type_template = ""
      @models.each do |model|
        columns = map_column_types(model)
        columns.concat(map_associations(model)) if TsSchema.configuration.include_associated
        
        type_template += <<~TYPESCRIPT
          interface #{model.model_name.param_key.camelize} {
          #{columns.map { |column| "#{indent_as_str}#{column_name_cased(column[:name])}: #{column[:ts_type]};" }.join("\n")}
          }\n
        TYPESCRIPT
      end
      type_template = <<~TPL
        declare namespace #{TsSchema.configuration.namespace} {
        #{indent_wrapper(type_template)}
        }
      TPL
    end

    def map_column_types(model)
      model.columns.map { |i|
        type = @types[i.type.to_s] || TsSchema.configuration.default_type

        if(enum = model.defined_enums[i.name])
          type = enum.keys.map { |k| "'#{k}'" }.join(" | ")
        end
    
        {
          name: "#{i.name}#{"?" if i.null }",
          ts_type: "#{type}#{" | null" if i.null}"
        }
      }
    end

    def map_associations(model)
      model.reflect_on_all_associations.reject(&:polymorphic?).map do |association|
        case
        when association.has_one? || association.belongs_to?
          {
            name: "#{association.name}?",
            ts_type: association.class_name
          }
        when association.collection?
          {
            name: "#{association.name}?",
            ts_type: "#{association.class_name}[]"
          }
        end
      end
    end

    def column_name_cased(name)
      case TsSchema.configuration.case.to_sym
      when :camel
        name.camelize(:lower)
      when :pascal
        name.camelize
      else
        name
      end
    end

    def indent_as_str
      case TsSchema.configuration.indent.to_sym
      when :space || :spaces
        "".rjust(TsSchema.configuration.spaces, " ")
      else
        "\t"
      end
    end

    def indent_wrapper(str)
      case TsSchema.configuration.indent.to_sym
      when :space || :spaces
        str.indent(TsSchema.configuration.spaces)
      else
        str.indent(1, "\t")
      end
    end

  end
end
