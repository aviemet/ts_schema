require 'fileutils'

module TsSchema
  class SchemaGenerator
    attr_accessor :config
    attr_accessor :models

    def initialize(config = nil)
      @config = config || TsSchema::Configuration.new
			@models = []

      Rails.application.eager_load!
			@config.parent_classes.each do |parent|
				@models.concat(get_subclasses(parent.to_s.constantize))
			end
      unless @config.additional_models.empty?
        @models.concat(@config.additional_models.map do |m| 
          m.to_s.constantize
        end)
      end
      @types = @config.types.stringify_keys.merge(@config.custom_types.stringify_keys || {})
    end

    def get_subclasses(model)
      models = model.send(:subclasses)
      unless nested_empty?(models)
        models.concat(models.flat_map do |m|
          get_subclasses(m)
        end)
      end
      models
    end

    def generate
      type_template = ""
			
      @models.each do |model|
        columns = map_column_types(model)
        columns.concat(map_associations(model)) if @config.include_associated
        
        type_template += <<~TYPESCRIPT
          #{@config.schema_type} #{model.model_name.param_key.camelize} #{@config.schema_type.to_sym == :type ? "= " : ""}{
          #{columns.map { |column| "#{indent_as_str}#{column_name_cased(column[:name])}: #{column[:ts_type]};" }.join("\n")}
          }\n
        TYPESCRIPT
      end

      type_template = <<~TPL
        declare namespace #{@config.namespace} {
        #{indent_wrapper(type_template)}
        }
      TPL
    end

    def output_file
      path = @config.output
      FileUtils.mkdir_p(File.dirname(path))

      content = generate
      return if File.exist?(path) && File.read(path) == content

      File.open(path, 'w') do |f|
        f.write content
      end
    end

    def map_column_types(model)
      model.columns.map { |i|
        type = @types[i.type.to_s] || @config.default_type

        if(enum = model.defined_enums[i.name])
          type = enum.keys.map { |k| "'#{k}'" }.join("|")
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
            ts_type: association.class_name.constantize.model_name.param_key.camelize
          }
        when association.collection?
          {
            name: "#{association.name}?",
            ts_type: "#{association.class_name.constantize.model_name.param_key.camelize}[]"
          }
        end
      end
    end

    private

    def nested_empty?(arr)
      arr.is_a?(Array) && arr.flatten.empty?
    end

    def column_name_cased(name)
      case @config.case.to_sym
      when :camel
        name.camelize(:lower)
      when :pascal
        name.camelize
      else
        name
      end
    end

    def indent_as_str
      case @config.indent.to_sym
      when :space || :spaces
        "".rjust(@config.spaces, " ")
      else
        "\t"
      end
    end

    def indent_wrapper(str)
      case @config.indent.to_sym
      when :space || :spaces
        str.indent(@config.spaces)
      else
        str.indent(1, "\t")
      end
    end

  end
end
