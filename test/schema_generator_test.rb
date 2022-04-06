require "test_helper"

class SchemaGeneratorTest < ActiveSupport::TestCase
  test "map_column_types generates a hash with mapped column schema values" do
    generator = TsSchema::SchemaGenerator.new
    map = generator.map_column_types(Example)
    [
      {:name=>"id", :ts_type=>"number"},
      {:name=>"col_string", :ts_type=>"string"},
      {:name=>"col_text", :ts_type=>"string"},
      {:name=>"col_integer", :ts_type=>"number"},
      {:name=>"col_enum", :ts_type=>"'zero' | 'one' | 'two'"},
      {:name=>"col_bigint", :ts_type=>"number"},
      {:name=>"col_float", :ts_type=>"number"},
      {:name=>"col_decimal", :ts_type=>"number"},
      {:name=>"col_json?", :ts_type=>"Record<string, any> | null"},
      {:name=>"col_jsonb?", :ts_type=>"Record<string, any> | null"},
      {:name=>"col_binary?", :ts_type=>"string | null"},
      {:name=>"col_boolean?", :ts_type=>"boolean | null"},
      {:name=>"col_date?", :ts_type=>"string | null"},
      {:name=>"col_datetime?", :ts_type=>"string | null"},
      {:name=>"col_timestamp?", :ts_type=>"string | null"},
      {:name=>"col_inet?", :ts_type=>"string | null"},
      {:name=>"col_cidr?", :ts_type=>"string | null"},
      {:name=>"col_macaddr?", :ts_type=>"string | null"},
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
end
