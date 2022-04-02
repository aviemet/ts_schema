# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/base'

module TsSchema
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates ts_schmea.rb in config/initializers with default options."

      def copy_initializer
        template "ts_schema.rb", "config/initializers/ts_schema.rb"
      end
    end
  end
end
