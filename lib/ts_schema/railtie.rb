require "rails"
require "ts_schema"

module TsSchema
  class Railtie < ::Rails::Railtie
    load "tasks/ts_schema_tasks.rake"
  end
end
