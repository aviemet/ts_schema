require "test_helper"

class SchemaGeneratorTest < ActiveSupport::TestCase
  test "map_column_types generates a hash with mapped column schema values" do
    generator = TsSchema::SchemaGenerator.new
    map = generator.map_column_types(Example)
    [
      {:name => "id", :ts_type => "number"},
      {:name => "col_string", :ts_type => "string"},
      {:name => "col_text", :ts_type => "string"},
      {:name => "col_integer", :ts_type => "number"},
      {:name => "col_enum", :ts_type => "'zero'|'one'|'two'"},
      {:name => "col_bigint", :ts_type => "number"},
      {:name => "col_float", :ts_type => "number"},
      {:name => "col_decimal", :ts_type => "number"},
      {:name => "col_json?", :ts_type => "Record<string, any>"},
      {:name => "col_jsonb?", :ts_type => "Record<string, any>"},
      {:name => "col_binary?", :ts_type => "string"},
      {:name => "col_boolean?", :ts_type => "boolean"},
      {:name => "col_date?", :ts_type => "string"},
      {:name => "col_datetime?", :ts_type => "string"},
      {:name => "col_timestamp?", :ts_type => "string"},
      {:name => "col_inet?", :ts_type => "string"},
      {:name => "col_cidr?", :ts_type => "string"},
      {:name => "col_macaddr?", :ts_type => "string"},
    ].each do |f|
      assert_includes(map, f)
    end
  end

  test "it overrides type maps when provided custom types" do
    config = TsSchema::Configuration.new({custom_types: { integer: :string }})
    generator = TsSchema::SchemaGenerator.new(config)
    map = generator.map_column_types(One)

    assert_includes(map, { name: "example_id", ts_type: "string" })
  end

  test "it includes all subclasses of ApplicationRecord" do
    generator = TsSchema::SchemaGenerator.new

    assert_includes(generator.models.map(&:name), "Inherit")
    assert_includes(generator.models.map(&:name), "Deep")
  end

  test "it doesn't include models which don't inherit from ApplicationRecord by default" do
    generator = TsSchema::SchemaGenerator.new
    refute_includes(generator.models.map(&:name), "Base")
  end

  test "it includes models defined in additional_models config" do
    config = TsSchema::Configuration.new({additional_models: ["Base"]})
    generator = TsSchema::SchemaGenerator.new(config)

    assert_includes(generator.models.map(&:name), "Base")
  end

  test "it generates schema as type when the option is set" do
    config = TsSchema::Configuration.new({schema_type: :type})
    generator = TsSchema::SchemaGenerator.new(config)
    assert_match "type Example = {", generator.generate
    refute_match "interface Example {", generator.generate
  end

  test "it outputs a namespace from the option" do
    config = TsSchema::Configuration.new({namespace: "different"})
    generator = TsSchema::SchemaGenerator.new(config)

    assert_match "namespace different", generator.generate
    refute_match "namespace schema", generator.generate
  end

  test "it respects field naming overrides" do
    config = TsSchema::Configuration.new({field_overrides: {
      "encrypted_password" => :password,
      "password" => :optional,
      "omit" => :omit,
      "deep" => "nesting",
      "nesting" => "level",
    }})
    generator = TsSchema::SchemaGenerator.new(config)
    map = generator.map_column_types(Override)

    assert_includes map, {name: "password?", ts_type: "string"}
    refute_includes map, {name: "encrypted_password", ts_type: "string"}
    refute_includes map, {name: "omit?", ts_type: "string"}
    refute_includes map, {name: "deep?", ts_type: "string"}
    refute_includes map, {name: "nesting?", ts_type: "string"}
    assert_includes map, {name: "level?", ts_type: "string"}
  end

  test "it respect field name type overrides" do
    config = TsSchema::Configuration.new({field_type_overrides: {
      "deep" => "'option1'|'option2'"
    }})
    generator = TsSchema::SchemaGenerator.new(config)
    map = generator.map_column_types(Override)

    assert_includes map, {name: "deep?", ts_type: "'option1'|'option2'"}
  end
end
