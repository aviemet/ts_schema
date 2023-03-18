# frozen_string_literal: true

require "rails"

module TsSchema
  class Railtie < ::Rails::Railtie
    load "tasks/ts_schema_tasks.rake"
  end
end
