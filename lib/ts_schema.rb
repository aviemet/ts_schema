# frozen_string_literal: true

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
      if check_migrations!
        puts "Aborting: There are pending migrations"
      else
        SchemaGenerator.new(@configuration).generate
      end
    end

    def output_file
      if check_migrations!
        puts "Aborting: There are pending migrations"
      else
        SchemaGenerator.new(@configuration).output_file
      end
    end

    private

    def check_migrations!
      return ActiveRecord::Base.connection.migration_context.needs_migration? if Rails.version < '7'

      ActiveRecord::Migration.check_all_pending!
    end
  end
end

require "generators/install_generator"
