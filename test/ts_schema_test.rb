require "test_helper"

class TsSchemaTest < ActiveSupport::TestCase
  test "it loads custom config values from initializer" do
    assert TsSchema.configuration.case
    assert TsSchema.configuration.output
    assert TsSchema.configuration.auto_generate
    assert TsSchema.configuration.types
    assert TsSchema.configuration.custom_types
    assert TsSchema.configuration.default_type
    assert TsSchema.configuration.include_associated
    assert TsSchema.configuration.namespace
    assert TsSchema.configuration.schema_type
    assert TsSchema.configuration.parent_classes
  end

  test "it generates a schema file" do
    path = TsSchema.configuration.output
    File.delete(path) if File.exist?(path)

    TsSchema.output_file
    assert File.exist?(path)
  end

  test "it has a version number" do
    assert TsSchema::VERSION
  end
end
