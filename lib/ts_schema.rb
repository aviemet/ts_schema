require "ts_schema/version"
require "ts_schema/railtie"

require "ts_schema/configuration"
require "ts_schema/schema_generator"


module TsSchema
  class << self
    def setup(&block)
      configuration.assign(&block)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def generate
      if ActiveRecord::Base.connection.migration_context.needs_migration?
        puts "Aborting: There are pending migrations"
      else 
        SchemaGenerator.new.generate
      end
    end

		def output_file
      if ActiveRecord::Base.connection.migration_context.needs_migration?
        puts "Aborting: There are pending migrations"
      else 
        SchemaGenerator.new.output_file
      end
		end
  end
end

require "generators/install_generator"
require "generators/generate_generator"
