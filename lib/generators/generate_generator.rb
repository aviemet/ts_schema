# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/base'

module TsSchema
  module Generators
    class GenerateGenerator < Rails::Generators::Base

      desc "Generates a schema.d.ts file"

      def generate_schema
        create_file TsSchema.configuration.output, TsSchema.generate
      end
    end
  end
end
