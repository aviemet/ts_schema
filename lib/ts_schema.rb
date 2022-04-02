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
      SchemaGenerator.new.generate
    end
  end
end